//
//  ColorSlider.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/17.
//

import SwiftUI

struct ColorSlider: View {
    @Binding var value: Double
    
    let color: Color
    let colors: [Color]
    
    private static let size: CGFloat = 36
    
    var body: some View {
        let size1 = ColorSlider.size - 6
        let size2 = size1 - 6
        let offset = size1 / 2
        ZStack {
            LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
            GeometryReader {
                let range = $0.size.width - size1
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: size1, height: size1)
                        .shadow(radius: 10)
                    Circle()
                        .fill(color)
                        .frame(width: size2, height: size2)
                        .shadow(radius: 10)
                }
                .position(x: CGFloat(value) * range + offset, y: offset)
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .named("ColorSlider"))
                            .onChanged { e in
                                let newValue = (e.location.x - offset) / range
                                if newValue < 0 {
                                    value = 0
                                }
                                else if newValue > 1 {
                                    value = 1
                                }
                                else {
                                    value = Double(newValue)
                                }
                            })
            }
            .coordinateSpace(name: "ColorSlider")
            .padding(3)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: ColorSlider.size)
        .clipShape(Capsule())
    }
}

struct ColorSlider_Previews: PreviewProvider {
    static var previews: some View {
        var value = 0.3
        let _value = Binding<Double>(get: { value }, set: { value = $0 })
        ColorSlider(value: _value, color: .purple, colors: [.red, .blue])
    }
}
