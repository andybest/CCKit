//
//  File.swift
//  
//
//  Created by Andy Best on 27/06/2020.
//

import Foundation
import CoreGraphics

class CoreGraphicsRenderer: Renderer {
    let type: OutputType
    let size: Vec2
    let context: CGContext

    var pdfClosed = false
    var pdfData = NSMutableData()

    var fillColor: Color {
        didSet { context.setFillColor(fillColor.cgColor) }
    }

    var strokeColor: Color {
        didSet { context.setStrokeColor(strokeColor.cgColor) }
    }

    var strokeWidth: Double {
        didSet { context.setLineWidth(CGFloat(strokeWidth)) }
    }

    var fillEnabled: Bool = true
    var strokeEnabled: Bool = true

    init(type: OutputType, size: Vec2) {
        self.type = type
        self.size = size

        switch type {
        case .bitmap:
            let colorspace = CGColorSpaceCreateDeviceRGB()
            guard let ctx = CGContext(data: nil,
                                      width: Int(size.width),
                                      height: Int(size.height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: 0,
                                      space: colorspace,
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
                                        fatalError("Could not create context")
            }
            self.context = ctx
        case .pdf:
            var pdfRect = CGRect(x: 0, y: 0, width: CGFloat(size.width), height: CGFloat(size.height))

            guard let consumer = CGDataConsumer(data: pdfData as CFMutableData) else {
                fatalError("Could not create data consumer")
            }

            guard let ctx = CGContext(consumer: consumer, mediaBox: &pdfRect, nil) else {
                fatalError("Could not create PDF context")
            }
            self.context = ctx

            context.beginPDFPage(nil)
        }

        fillColor = Color(red: 1, green: 1, blue: 1)
        strokeColor = Color(red: 1, green: 0, blue: 0)
        strokeWidth = 1
    }

    func output(to path: String) {
        switch type {
        case .pdf:
            context.endPDFPage()
            context.closePDF()
            do {
                try pdfData.write(toFile: path, options: [])
            } catch {
                fatalError("Could not write PDF document to path \(path)")
            }
        case .bitmap:
            guard let image = context.makeImage() else { fatalError("Unable to render to image") }

            let url = URL(fileURLWithPath: path)
            guard let consumer = CGDataConsumer(url: url as CFURL) else {
                fatalError("Unable to create data consumer")
            }

            guard let destination = CGImageDestinationCreateWithDataConsumer(consumer, kUTTypePNG, 1, nil) else {
                fatalError("Unable to create image destination")
            }

            CGImageDestinationAddImage(destination, image, nil)
            CGImageDestinationFinalize(destination)
        }
    }

    private func fillStroke() {
        guard let path = context.path else { return }

        if fillEnabled {
            context.fillPath()
        }

        if strokeEnabled {
            if fillEnabled { context.addPath(path) }
            context.strokePath()
        }
    }

    // MARK: Drawable Implementation

    func rect(rect: Rect) {
        if fillEnabled { context.fill(rect.cgRect) }
        if strokeEnabled { context.stroke(rect.cgRect) }
    }

    func line(p1: Vec2, p2: Vec2) {
        if strokeEnabled {
            context.strokeLineSegments(between: [p1.cgPoint, p2.cgPoint])
        }
    }

    func bezier(p1: Vec2, p2: Vec2, c1: Vec2, c2: Vec2) {
        context.beginPath()
        context.move(to: p1.cgPoint)
        context.addCurve(to: p2.cgPoint, control1: c1.cgPoint, control2: c2.cgPoint)
        if strokeEnabled { context.strokePath() }
    }

    func point(p: Vec2) {
        if strokeEnabled {
            let rect = CGRect(x: CGFloat(p.x), y: CGFloat(p.y), width: 1, height: 1)
            let tempFill = fillColor
            fillColor = strokeColor
            context.fill(rect)
            fillColor = tempFill
        }
    }

    func ellipse(rect: Rect) {
        if fillEnabled {
            context.fillEllipse(in: rect.cgRect)
        }
        if strokeEnabled {
            context.strokeEllipse(in: rect.cgRect)
        }
    }

    func arc(location: Vec2, radius: Double, start: Double, stop: Double, clockwise: Bool = true) {
        context.beginPath()
        context.addArc(center: location.cgPoint,
                       radius: CGFloat(radius),
                       startAngle: CGFloat(start),
                       endAngle: CGFloat(stop),
                       clockwise: clockwise)

        fillStroke()
    }

    func path(points: [Vec2], close: Bool) {
        guard !points.isEmpty else { return }
        guard points.count > 1 else {
            point(x: points[0].x, y: points[0].y)
            return
        }

        context.beginPath()
        context.move(to: points[0].cgPoint)

        for p in points.dropFirst() {
            context.addLine(to: p.cgPoint)
        }

        if close {
            context.closePath()
        }

        fillStroke()
    }

}

extension Color {
    /// CGColor value
    var cgColor: CGColor {
        let c = rgb
        return CGColor(red: CGFloat(c.x), green: CGFloat(c.y), blue: CGFloat(c.z), alpha: CGFloat(c.a))
    }
}
