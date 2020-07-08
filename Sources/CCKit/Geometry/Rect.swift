//
//  File.swift
//  
//
//  Created by Andy Best on 27/06/2020.
//

import Foundation
import CoreGraphics

public struct Rect {
    public var origin: Vec2
    public var size: Vec2

    public var x: Double { origin.x }
    public var y: Double { origin.y }
    public var width: Double { size.width }
    public var height: Double { size.height }

    var cgRect: CGRect { CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height)) }

    public init(x: Double, y: Double, width: Double, height: Double) {
        origin = Vec2(x: x, y: y)
        size = Vec2(width: width, height: height)
    }

    public init(origin: Vec2, size: Vec2) {
        self.origin = origin
        self.size = size
    }

    init(cgRect: CGRect) {
        self.origin = Vec2(x: Double(cgRect.origin.x), y: Double(cgRect.origin.y))
        self.size = Vec2(width: Double(cgRect.size.width), height: Double(cgRect.size.height))
    }
}
