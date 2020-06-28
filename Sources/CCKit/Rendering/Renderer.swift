//
//  File.swift
//  
//
//  Created by Andy Best on 27/06/2020.
//

import Foundation

public enum OutputType {
    case bitmap
    case pdf
}

protocol Renderer: Drawable {
    func output(to path: String)
}
