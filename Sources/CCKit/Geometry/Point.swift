//
//  File.swift
//  
//
//  Created by Andy Best on 27/06/2020.
//

import Foundation
import CoreGraphics

public struct Point {
    public var x: Double
    public var y: Double

    var cgPoint: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    init(cgPoint: CGPoint) {
        x = Double(cgPoint.x)
        y = Double(cgPoint.y)
    }
}
