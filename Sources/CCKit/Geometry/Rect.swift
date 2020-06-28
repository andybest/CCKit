//
//  File.swift
//  
//
//  Created by Andy Best on 27/06/2020.
//

import Foundation
import CoreGraphics

public struct Rect {
    public var origin: Point
    public var size: Size

    public var x: Double { origin.x }
    public var y: Double { origin.y }
    public var width: Double { size.width }
    public var height: Double { size.height }

    var cgRect: CGRect { CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height)) }

    public init(x: Double, y: Double, width: Double, height: Double) {
        origin = Point(x: x, y: y)
        size = Size(width: width, height: height)
    }

    public init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }

    init(cgRect: CGRect) {
        self.origin = Point(x: Double(cgRect.origin.x), y: Double(cgRect.origin.y))
        self.size = Size(width: Double(cgRect.size.width), height: Double(cgRect.size.height))
    }
}
