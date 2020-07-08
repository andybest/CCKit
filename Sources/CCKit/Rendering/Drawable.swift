//
//  File.swift
//  
//
//  Created by Andy Best on 27/06/2020.
//

import Foundation

public protocol Drawable: AnyObject {
    var size: Vec2 { get }
    var fillColor: Color { get set }
    var strokeColor: Color { get set }
    var strokeWidth: Double { get set }
    var fillEnabled: Bool { get set }
    var strokeEnabled: Bool { get set }

    func point(p: Vec2)
    func line(p1: Vec2, p2: Vec2)
    func bezier(p1: Vec2, p2: Vec2, c1: Vec2, c2: Vec2)
    func rect(rect: Rect)
    func ellipse(rect: Rect)
    func arc(location: Vec2, radius: Double, start: Double, stop: Double, clockwise: Bool)
    func path(points: [Vec2], close: Bool)
}

// MARK: - Convenience functions

public extension Drawable {

    func noStroke() { strokeEnabled = false }

    func setStroke() { strokeEnabled = true }

    func setFill() { fillEnabled = true}

    func noFill() { fillEnabled = false }

    func point(x: Double, y: Double) {
        point(p: Vec2(x: x, y: y))
    }

    func line(x1: Double, y1: Double, x2: Double, y2: Double) {
        line(p1: Vec2(x: x1, y: y1), p2: Vec2(x: x2, y: y2))
    }

    func bezier(x1: Double, y1: Double, x2: Double, y2: Double, cx1: Double, cy1: Double, cx2: Double, cy2: Double) {
        bezier(p1: Vec2(x: x1, y: y1), p2: Vec2(x: x2, y: y2), c1: Vec2(x: cx1, y: cy1), c2: Vec2(x: cx2, y: cy2))
    }

    func square(x: Double, y: Double, extent: Double) {
        rect(x: x, y: y, width: extent, height: extent)
    }

    func rect(location: Vec2, size: Vec2) {
        rect(rect: Rect(origin: location, size: size))
    }

    func rect(x: Double, y: Double, width: Double, height: Double) {
        rect(rect: Rect(x: x, y: y, width: width, height: height))
    }

    func ellipse(location: Vec2, size: Vec2) {
        ellipse(rect: Rect(origin: location, size: size))
    }

    func ellipse(x: Double, y: Double, width: Double, height: Double) {
        ellipse(rect: Rect(x: x, y: y, width: width, height: height))
    }

    func circle(location: Vec2, radius: Double) {
        ellipse(location: location, size: Vec2(width: radius, height: radius))
    }

    func circle(x: Double, y: Double, radius: Double) {
        ellipse(x: x, y: y, width: radius, height: radius)
    }

    func arc(x: Double, y: Double, radius: Double, start: Double, stop: Double, clockwise: Bool = true) {
        arc(location: Vec2(x: x, y: y), radius: radius, start: start, stop: stop, clockwise: clockwise)
    }

    func quad(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double, x4: Double, y4: Double) {
        quad(p1: Vec2(x: x1, y: y1),
             p2: Vec2(x: x2, y: y2),
             p3: Vec2(x: x3, y: y3),
             p4: Vec2(x: x4, y: y4))
    }

    func quad(p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2) {
        polygon(points: [p1, p2, p3, p4])
    }

    func triangle(p1: Vec2, p2: Vec2, p3: Vec2) {
        polygon(points: [p1, p2, p3])
    }

    func triangle(x1: Double, y1: Double, x2: Double, y2: Double, x3: Double, y3: Double) {
        triangle(p1: Vec2(x: x1, y: y1), p2: Vec2(x: x2, y: y2), p3: Vec2(x: x3, y: y3))
    }

    func polygon(points: [Vec2]) {
        path(points: points, close: true)
    }
}
