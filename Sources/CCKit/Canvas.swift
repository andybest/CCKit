//
//  File.swift
//  
//
//  Created by Andy Best on 27/06/2020.
//

import Foundation



open class Canvas {
    private var renderer: Renderer

    public init(size: Size, outputType: OutputType) {
        renderer = CoreGraphicsRenderer(type: outputType, size: size)
    }

    public func output(to path: String) {
        renderer.output(to: path)
    }
}

extension Canvas: Drawable {

    public var fillColor: Color {
        get { renderer.fillColor }
        set { renderer.fillColor = newValue }
    }

    public var strokeColor: Color {
        get { renderer.strokeColor }
        set { renderer.strokeColor = newValue }
    }

    public var strokeWidth: Double {
        get { renderer.strokeWidth }
        set { renderer.strokeWidth = newValue }
    }

    public var fillEnabled: Bool {
        get { renderer.fillEnabled }
        set { renderer.fillEnabled = false }
    }

    public var strokeEnabled: Bool {
        get { renderer.strokeEnabled }
        set { renderer.strokeEnabled = newValue }
    }

    public var size: Size { renderer.size }

    public func point(p: Point) {
        renderer.point(p: p)
    }

    public func line(p1: Point, p2: Point) {
        renderer.line(p1: p1, p2: p2)
    }

    public func bezier(p1: Point, p2: Point, c1: Point, c2: Point) {
        renderer.bezier(p1: p1, p2: p2, c1: c1, c2: c2)
    }

    public func rect(rect: Rect) {
        renderer.rect(rect: rect)
    }

    public func ellipse(rect: Rect) {
        renderer.ellipse(rect: rect)
    }

    public func arc(location: Point, radius: Double, start: Double, stop: Double, clockwise: Bool) {
        renderer.arc(location: location, radius: radius, start: start, stop: stop, clockwise: clockwise)
    }

    public func path(points: [Point], close: Bool) {
        renderer.path(points: points, close: close)
    }
}
