//
//  WidthPickerPopover.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/30.
//

import SwiftUI

struct WidthPickerPopover: View {
    @Binding var isPresented: Bool
    
    @State private var width: CGFloat = 0
    
    let widthElement: WidthElement
    let actionName: LocalizedStringKey
    let onAction: (WidthElement) -> Void
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Text("Width")
                    Spacer()
                }
                HStack {
                    Button("Cancel") {
                        isPresented = false
                    }
                    Spacer()
                    Button(actionName) {
                        onAction(WidthElement(width: width))
                        isPresented = false
                    }
                }
            }
            .padding()
            WidthPicker(width: $width)
            Spacer()
        }
        .frame(width: 360)
        .onAppear {
            width = widthElement.width
        }
    }
}

extension View {
    func widthPicker(isPresented: Binding<Bool>, widthElement: WidthElement = .thin, actionName: LocalizedStringKey, onAction: @escaping (WidthElement) -> Void) -> some View {
        self
            .popover(isPresented: isPresented) {
                WidthPickerPopover(isPresented: isPresented, widthElement: widthElement, actionName: actionName, onAction: onAction)
            }
    }
}

struct WidthPickerPopover_Previews: PreviewProvider {
    static var previews: some View {
        WidthPickerPopover(isPresented: .constant(true), widthElement: .thin, actionName: "Width", onAction: { _ in })
    }
}
