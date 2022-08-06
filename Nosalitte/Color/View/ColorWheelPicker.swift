//
//  ColorWheelPicker.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/17.
//

import SwiftUI

struct ColorWheelPicker: View {
    @ObservedObject var colorElement: ColorElement
    
    private static let size: CGFloat = 300
    
    var body: some View {
        return VStack {
            let radius = ColorWheelPicker.size / 2
            Capsule()
                .fill(colorElement.color)
                .frame(height: 10)
                .padding(.vertical)
            ZStack {
                let r: Double = Double(radius) * colorElement.s
                let radian: Double = colorElement.h * Double.pi * 2.0
                let x: Double = r * cos(radian) + 5.0
                let y: Double = r * sin(radian) + 5.0
                ColorWheel()
                Color.black
                    .opacity(1.0 - colorElement.v)
                Circle()
                    .fill(colorElement.color)
                    .overlay(
                        Circle()
                            .stroke(Color.black)
                    )
                    .position(x: CGFloat(x), y: CGFloat(y))
                    .fixedSize()
            }
            .frame(width: ColorWheelPicker.size, height: ColorWheelPicker.size)
            .clipShape(Circle())
            .contentShape(Circle())
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { e in
                            let x: CGFloat = radius - e.location.x
                            let y: CGFloat = radius - e.location.y
                            
                            let radian:Double = Double(atan2(y, x))
                            colorElement.h = (radian + Double.pi) / Double.pi / 2.0
                            
                            let distance: CGFloat = sqrt(x * x + y * y)
                            colorElement.s = min(1.0, Double(distance / radius))
                        })
            ColorSlider(value: $colorElement.v, color: colorElement.color, colors: [colorElement.clone(brightness: 0.0).color, colorElement.clone(brightness: 1.0).color])
                .padding(.top)
            ColorSlider(value: $colorElement.a, color: colorElement.color, colors: [colorElement.clone(opacity: 0.0).color, colorElement.clone(opacity: 1.0).color])
                .background(
                    BackgroundFiller(size: 12)
                        .clipShape(Capsule())
                )
                .padding(.vertical)
        }
        .padding(.horizontal)
    }
}

struct ColorWheelPicker_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ColorWheelPicker(colorElement: .red)
        }
    }
}
