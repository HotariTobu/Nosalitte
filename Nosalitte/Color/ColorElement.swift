//
//  ColorElement.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/23.
//

import SwiftUI

class ColorElement: ReorderableElement, ObservableObject {
    @Published var r: Double { willSet { updateHSV() } }
    @Published var g: Double { willSet { updateHSV() } }
    @Published var b: Double { willSet { updateHSV() } }
    @Published var a: Double
    @Published var h: Double { willSet { updateRGB() } }
    @Published var s: Double { willSet { updateRGB() } }
    @Published var v: Double { willSet { updateRGB() } }
    
    let id = UUID()
    var color: Color {
        Color(red: r, green: g, blue: b, opacity: a)
    }
    
    private var isUpdatable = false
    
    init(red: Double, green: Double, blue: Double, opacity: Double) {
        r = red
        g = green
        b = blue
        a = opacity
        h = 0
        s = 0
        v = 0
        isUpdatable = true
        updateHSV()
    }
    
    init(hue: Double, saturation: Double, brightness: Double, opacity: Double) {
        r = 0
        g = 0
        b = 0
        a = opacity
        h = hue
        s = saturation
        v = brightness
        isUpdatable = true
        updateRGB()
    }
    
    convenience init(red: Double, green: Double, blue: Double) {
        self.init(red: red, green: green, blue: blue, opacity: 1.0)
    }
    
    convenience init(hue: Double, saturation: Double, brightness: Double) {
        self.init(hue: hue, saturation: saturation, brightness: brightness, opacity: 1.0)
    }
    
    convenience init(white: Double) {
        self.init(hue: 0.0, saturation: 0.0, brightness: white, opacity: 1.0)
    }
    
    static func == (lhs: ColorElement, rhs: ColorElement) -> Bool {
        lhs.id == rhs.id
        //lhs.r == rhs.r && lhs.g == rhs.g && lhs.b == rhs.b && lhs.a == rhs.a
    }
    
    private func updateRGB() {
        guard isUpdatable else {
            return
        }
        
        let h = self.h < 1 ? self.h : 0
        
        let max = v
        let range = s * max
        let min = max - range
        
        let hd = Int(h * 6.0) % 6
        let hdd = Int(h * 3.0) % 3
        
        var rgb = [0.0, 0.0, 0.0]
        rgb[hdd] = max
        rgb[((hd + 1) / 2 + 1) % 3] = min
        rgb[(5 - hd) % 3] = (hd % 2 == 0 ? -1.0 : 1.0) * (h * 6.0 - Double(hdd) * 2.0 - 1.0) * range + min
        
        isUpdatable = false
        r = rgb[0]
        g = rgb[1]
        b = rgb[2]
        isUpdatable = true
    }
    
    private func updateHSV() {
        guard isUpdatable else {
            return
        }
        
        let max = max(r, g, b)
        let min = min(r, g, b)
        let range = max - min
        
        var h = 0.0
        let s = range / max
        let v = max
        
        if (range > 0)
        {
            switch max {
            case r:
                h = (g - b) / range + 1.0
            case g:
                h = (b - r) / range + 3.0
            default:
                h = (r - g) / range + 5.0
            }
            h /= 6.0
        }
        
        isUpdatable = false
        self.h = h
        self.s = s
        self.v = v
        isUpdatable = true
    }
}

extension ColorElement {
    convenience init(red: Int, green: Int, blue: Int, opacity: Int) {
        self.init(red: Double(red) / 255.5, green: Double(green) / 255.5, blue: Double(blue) / 255.5, opacity: Double(opacity) / 255.5)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: red, green: green, blue: blue, opacity: 255)
    }
}

extension ColorElement {
    func clone() -> ColorElement {
        ColorElement(red: r, green: g, blue: b, opacity: a)
    }
    
    func clone(red: Double) -> ColorElement {
        ColorElement(red: red, green: g, blue: b, opacity: a)
    }
    
    func clone(green: Double) -> ColorElement {
        ColorElement(red: r, green: green, blue: b, opacity: a)
    }
    
    func clone(blue: Double) -> ColorElement {
        ColorElement(red: r, green: g, blue: blue, opacity: a)
    }
    
    func clone(opacity: Double) -> ColorElement {
        ColorElement(red: r, green: g, blue: b, opacity: opacity)
    }
    
    func clone(hue: Double) -> ColorElement {
        ColorElement(hue: hue, saturation: s, brightness: v, opacity: a)
    }
    
    func clone(saturation: Double) -> ColorElement {
        ColorElement(hue: h, saturation: saturation, brightness: v, opacity: a)
    }
    
    func clone(brightness: Double) -> ColorElement {
        ColorElement(hue: h, saturation: s, brightness: brightness, opacity: a)
    }
}

extension ColorElement {
    static var white: ColorElement { ColorElement(white: 1.0) }
    static var gray: ColorElement { ColorElement(red: 142, green: 142, blue: 147) }
    static var black: ColorElement { ColorElement(white: 0.0) }
    static var red: ColorElement { ColorElement(red: 255, green: 60, blue: 47) }
    static var orange: ColorElement { ColorElement(red: 255, green: 149, blue: 2) }
    static var yellow: ColorElement { ColorElement(red: 255, green: 204, blue: 2) }
    static var green: ColorElement { ColorElement(red: 53, green: 199, blue: 89) }
    static var cyan: ColorElement { ColorElement(red: 14, green: 236, blue: 250) }
    static var blue: ColorElement { ColorElement(red: 0, green: 122, blue: 255) }
    static var purple: ColorElement { ColorElement(red: 175, green: 82, blue: 222) }
    static var pink: ColorElement { ColorElement(red: 255, green: 44, blue: 85) }
}
