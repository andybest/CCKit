//
//  File.swift
//  
//
//  Created by Andy Best on 27/06/2020.
//

import Foundation
import XCTest

@testable import CCKit

class ColorTests: XCTestCase {

    func test_RGBtoHSLConversion() {
        let red = Color(red: 1, green: 0, blue: 0)
        XCTAssertEqual(red.hue, 0, accuracy: 0.001)
        XCTAssertEqual(red.saturation, 1, accuracy: 0.001)
        XCTAssertEqual(red.lightness, 0.5, accuracy: 0.001)

        let green = Color(red: 0, green: 1, blue: 0)
        XCTAssertEqual(green.hue, 120, accuracy: 0.001)
        XCTAssertEqual(green.saturation, 1, accuracy: 0.001)
        XCTAssertEqual(green.lightness, 0.5, accuracy: 0.001)

        let blue = Color(red: 0, green: 0, blue: 1)
        XCTAssertEqual(blue.hue, 240, accuracy: 0.001)
        XCTAssertEqual(blue.saturation, 1, accuracy: 0.001)
        XCTAssertEqual(blue.lightness, 0.5, accuracy: 0.001)

        let grey = Color(red: 0.5, green: 0.5, blue: 0.5)
        XCTAssertEqual(grey.hue, 0, accuracy: 0.001)
        XCTAssertEqual(grey.saturation, 0, accuracy: 0.001)
        XCTAssertEqual(grey.lightness, 0.5, accuracy: 0.001)
    }

    func test_HSLtoRGBConversion() {
        let red = Color(hue: 0, saturation: 1, lightness: 0.5)
        XCTAssertEqual(red.r, 1, accuracy: 0.001)
        XCTAssertEqual(red.g, 0, accuracy: 0.001)
        XCTAssertEqual(red.b, 0, accuracy: 0.001)

        let green = Color(hue: 120, saturation: 1, lightness: 0.5)
        XCTAssertEqual(green.r, 0, accuracy: 0.001)
        XCTAssertEqual(green.g, 1, accuracy: 0.001)
        XCTAssertEqual(green.b, 0, accuracy: 0.001)

        let blue = Color(hue: 240, saturation: 1, lightness: 0.5)
        XCTAssertEqual(blue.r, 0, accuracy: 0.001)
        XCTAssertEqual(blue.g, 0, accuracy: 0.001)
        XCTAssertEqual(blue.b, 1, accuracy: 0.001)
    }
}
