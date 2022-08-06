//
//  ColorPickerPopover.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/22.
//

import SwiftUI

struct ColorPickerPopover: View {
    @Binding var isPresented: Bool
    
    let colorElement: ColorElement
    let actionName: LocalizedStringKey
    let onAction: (ColorElement) -> Void
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Text("Color")
                    Spacer()
                }
                HStack {
                    Button("Cancel") {
                        isPresented = false
                    }
                    Spacer()
                    Button(actionName) {
                        onAction(colorElement)
                        isPresented = false
                    }
                }
            }
            .padding()
            ColorWheelPicker(colorElement: colorElement)
            Spacer()
        }
        .frame(width: 360)
    }
}

extension View {
    func colorPicker(isPresented: Binding<Bool>, colorElement: ColorElement = .white, actionName: LocalizedStringKey, onAction: @escaping (ColorElement) -> Void) -> some View {
        self
            .popover(isPresented: isPresented) {
                ColorPickerPopover(isPresented: isPresented, colorElement: colorElement, actionName: actionName, onAction: onAction)
            }
    }
}

struct ColorPickerPopover_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerPopover(isPresented: .constant(true), colorElement: .blue, actionName: "Add", onAction: {_ in })
    }
}
