//
//  File.swift
//  
//
//  Created by Andy Best on 27/06/2020.
//

import Foundation
import CoreGraphics

public struct Size {
    public var width: Double
    public var height: Double

    var cgSize: CGSize { CGSize(width: CGFloat(width), height: CGFloat(height)) }

    public init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    init(cgSize: CGSize) {
        width = Double(cgSize.width)
        height = Double(cgSize.height)
    }
}
