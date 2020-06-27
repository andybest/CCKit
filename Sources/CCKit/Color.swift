//
//  File.swift
//  
//
//  Created by Andy Best on 25/06/2020.
//

import Foundation



struct ColorStorage {
    var x: Float
    var y: Float
    var z: Float
    var a: Float

    var r: Float { x }
    var g: Float { y }
    var b: Float { z }

    var h: Float { x }
    var s: Float { y }
    var l: Float { z }

    func rgbToHsl() -> ColorStorage {
        let minVal = min(r, min(g, b))
        let maxVal = max(r, max(g, b))
        let luminance = (minVal + maxVal) / 2

        // If there is no saturation, there is no hue
        if minVal == maxVal {
            return ColorStorage(x: 0, y: 0, z: luminance, a: a)
        }

        let saturation: Float

        if luminance < 0.5 {
            saturation = (maxVal - minVal) / (maxVal + minVal)
        } else {
            saturation = (maxVal - minVal) / (2 - maxVal - minVal)
        }

        let hue: Float

        if r == maxVal  {
            hue = (g - b) / (maxVal - minVal)
        } else if g == maxVal {
            hue = 2 + (b - r) / (maxVal - minVal)
        } else {
            hue = 4 + (r - g) / (maxVal - minVal)
        }

        // Convert hue to a value of 0..360
        return ColorStorage(x: hue * 60, y: saturation, z: luminance, a: a)
    }

    private func calculateHue(tc: Float, t1: Float, t2: Float) -> Float {
        if 6 * tc < 1 {
            return t2 + (t1 - t2) * 6 * tc
        } else if 2 * tc < 1 {
            return t1
        } else if 3 * tc < 2 {
            return t2 + (t1 - t2) * ((2 / 3) - tc) * 6
        }

        return t2
    }

    func hslToRgb() -> ColorStorage {
        // If there is no saturation, return lightness
        if s == 0 {
            return ColorStorage(x: l, y: l, z: l, a: a)
        }

        let t1 = l < 0.5 ? l * (s + 1) : l + s - l * s
        let t2 = 2 * l - t1
        let hueNormalised = h / 360

        // Make sure value is in the range 0..1
        let normalizeValue: (Float) -> Float = { (x: Float) in (x < 0) ? 1 + x : (x > 1) ? x - 1 : x }

        let tr = normalizeValue(hueNormalised + (1 / 3))
        let tg = normalizeValue(hueNormalised)
        let tb = normalizeValue(hueNormalised - (1 / 3))

        return ColorStorage(x: calculateHue(tc: tr, t1: t1, t2: t2),
                            y: calculateHue(tc: tg, t1: t1, t2: t2),
                            z: calculateHue(tc: tb, t1: t1, t2: t2),
                            a: a)
    }
}

enum ColorType {
    case rgb
    case hsl
}

struct Color {
    private var storage: ColorStorage
    private var type: ColorType

    /// Alpha component
    var a: Float { storage.a }

    var rgb: ColorStorage {
        switch type {
        case .rgb: return storage
        case .hsl: return storage.hslToRgb()
        }
    }

    var hsl: ColorStorage {
        switch type {
        case .rgb: return storage.rgbToHsl()
        case .hsl: return storage
        }
    }

    /// Red component
    var r: Float { rgb.x }

    /// Green component
    var g: Float { rgb.y }

    /// Blue component
    var b: Float { rgb.z }

    var hue: Float { hsl.x }

    var saturation: Float { hsl.y }

    var lightness: Float { hsl.z }

    /// CGColor value
    var cgColor: CGColor {
        let c = rgb
        return CGColor(red: CGFloat(c.x), green: CGFloat(c.y), blue: CGFloat(c.z), alpha: CGFloat(c.a))
    }

    /// Red, Green, Blue, Alpha expressed as floats in the range 0..1
    init(red: Float, green: Float, blue: Float, alpha: Float = 1.0) {
        type = .rgb
        storage = ColorStorage(x: red, y: green, z: blue, a: alpha)
    }

    /// Hue, Saturation, Lightness, Alpha expressed as floats in the range 0..1
    init(hue: Float, saturation: Float, lightness: Float, alpha: Float = 1.0) {
        type = .hsl
        storage = ColorStorage(x: hue, y: saturation, z: lightness, a: alpha)
    }

    //init(luminance: Float, a)
}
