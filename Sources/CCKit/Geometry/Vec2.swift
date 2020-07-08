//
//  File.swift
//  
//
//  Created by Andy Best on 27/06/2020.
//

import Foundation
import CoreGraphics

public typealias Scalar = Double
public typealias Vec2 = SIMD2<Scalar>

public extension Vec2 {
    var cgPoint: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}

public extension Vec2 {
    init(width: Scalar, height: Scalar) {
        self.init(x: width, y: height)
    }

    var width: Scalar { x }
    var height: Scalar { y }
    var cgSize: CGSize { CGSize(width: CGFloat(x), height: CGFloat(y)) }
}
