//
//  File.swift
//  
//
//  Created by Andy Best on 27/06/2020.
//

import Foundation
import CCKit


class Pastelizer: Canvas {

    func draw() {
        noStroke()

        let saturation = 0.3
        let lightness = 0.4

        for _ in 0..<10000 {
            let y: Double = .random(in: -100..<size.height)
            let yNorm = 1 - (y / size.height)
            let offset = 190.0 + (90 * yNorm)
            let spread = 6.0
            let hue1 = 0.0 + offset
            let hue2 = hue1 + spread
            let hue3 = hue2 + spread

            let ySat = saturation + (0.1 * yNorm)
            let yLightness = lightness //- (0.1 * yNorm)

            let hue = [hue1, hue2, hue3].randomElement()!
            fillColor = Color(hue: hue * .random(in: 0.9..<1.1),
                              saturation: ySat * .random(in: 0.9..<1.1),
                              lightness: yLightness * .random(in: 0.9..<1.1),
                              alpha: 0.125)

            circle(x: .random(in: -100..<size.width),
                   y: y,
                   radius: .random(in: 5..<100))
        }

        noFill()
        setStroke()
        strokeWidth = 3

        strokeColor = Color(hue: 35 + 190,
                            saturation: 0.25,
                            lightness: 0.8,
                            alpha: 1.0)

        drawArcs()
    }

    func drawArcs() {
        let steps = 40
        let arcStep: Double = ((.pi * 2) / Double(steps / 9)) * 1.318
        let startRadius = (size.width / 3)
        let endRadius = 0.0
        let radiusStep = ((startRadius - endRadius) / Double(steps))
        let location = Point(x: size.width / 2, y: size.height / 2)

        for i in (0..<steps).reversed() {
            let radius = startRadius - (Double(i) * radiusStep)
            let arcStart = (Double(i) * arcStep)
            let arcEnd = arcStart + arcStep

            arc(location: location,
                radius: radius,
                start: arcStart,
                stop: arcEnd,
                clockwise: false)
        }
    }
}

let test = Pastelizer(size: Vec2(width: 900, height: 900), outputType: .pdf)
test.draw()
test.output(to: "/Users/andy.best/Desktop/cc/pastel_6.pdf")
