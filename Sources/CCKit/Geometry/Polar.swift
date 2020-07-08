//
//  File.swift
//  
//
//  Created by Andy Best on 08/07/2020.
//

import Foundation

/// A structure representing a polar coordinate
public struct Polar {
    public var radius: Scalar
    public var angle: Scalar

    public init(radius: Scalar, angle: Scalar) {
        self.radius = radius
        self.angle = angle
    }
}

public  extension Polar {
    /// Converts from polar coordinates to Cartesian coordinates
    var point: Vec2 { Vec2(x: cos(angle) * radius, y: sin(angle) * radius) }
}
