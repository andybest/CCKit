//
//  File.swift
//  
//
//  Created by Andy Best on 27/06/2020.
//

import Foundation

public protocol Drawable: AnyObject {
    var size: Size { get }
    var fillColor: Color { get set }
    var strokeColor: Color { get set }
    var strokeWidth: Double { get set }
    var fillEnabled: Bool { get set }
    var strokeEnabled: Bool { get set }

    func point(p: Point)
    func line(p1: Point, p2: Point)
    func bezier(p1: Point, p2: Point, c1: Point, c2: Point)
    func rect(rect: Rect)
    func ellipse(rect: Rect)
    func arc(location: Point, radius: Double, start: Double, stop: Double, clockwise: Bool)
    func path(points: [Point], close: Bool)
}

// MARK: - Convenience functions

public extension Drawable {

    func noStroke() { strokeEnabled = false }

    func setStroke() { strokeEnabled = true }

    func setFill() { fillEnabled = true}

    func noFill() { fillEnabled = false }

    func point(x: Double, y: Double) {
        point(p: Point(x: x, y: y))
    }

    func line(x1: Double, y1: Double, x2: Double, y2: Double) {
        line(p1: Point(x: x1, y: y1), p2: Point(x: x2, y: y2))
    }

    func bezier(x1: Double, y1: Double, x2: Double, y2: Double, cx1: Double, cy1: Double, cx2: Double, cy2: Double) {
        bezier(p1: Point(x: x1, y: y1), p2: Point(x: x2, y: y2), c1: Point(x: cx1, y: cy1), c2: Point(x: cx2, y: cy2))
    }

    func square(x: Double, y: Double, extent: Double) {
        rect(x: x, y: y, width: extent, height: extent)
    }

    func rect(location: Point, size: Size) {
        rect(rect: Rect(origin: location, size: size))
    }

    func rect(x: Double, y: Double, width: Double, height: Double) {
        rect(rect: Rect(x: x, y: y, width: width, height: height))
    }

    func ellipse(location: Point, size: Size) {
        ellipse(rect: Rect(origin: location, size: size))
    }

    func ellipse(x: Double, y: Double, width: Double, height: Double) {
        ellipse(rect: Rect(x: x, y: y, width: width, height: height))
    }

    func circle(location: Point, radius: Double) {
        ellipse(location: location, size: Size(width: radius, height: radius))
    }

    func circle(x: Double, y: Double, radius: Double) {
        ellipse(x: x, y: y, width: radius, height: radius)
    }

    func arc(x: Double, y: Double, radius: Double, start: Double, stop: Double, clockwise: Bool = true) {
        arc(location: Point(x: x, y: y), radius: radius, start: start, stop: stop, clockwise: clockwise)
    }

    func quad(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double, x4: Double, y4: Double) {
        quad(p1: Point(x: x1, y: y1),
             p2: Point(x: x2, y: y2),
             p3: Point(x: x3, y: y3),
             p4: Point(x: x4, y: y4))
    }

    func quad(p1: Point, p2: Point, p3: Point, p4: Point) {
        polygon(points: [p1, p2, p3, p4])
    }

    func triangle(p1: Point, p2: Point, p3: Point) {
        polygon(points: [p1, p2, p3])
    }

    func triangle(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double) {
        triangle(p1: Point(x: x1, y: y1), p2: Point(x: x2, y: y2), p3: Point(x: x3, y: y3))
    }

    func polygon(points: [Point]) {
        path(points: points, close: true)
    }
}
