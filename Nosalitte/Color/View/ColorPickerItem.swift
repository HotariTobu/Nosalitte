//
//  ColorPickerItem.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/18.
//

import SwiftUI

struct ColorPickerItem: View {
    @State private var isPopoverPresented = false
    
    let onAction: (ColorElement) -> Void
    
    var body: some View {
        ColorWheel()
            .onTapGesture {
                isPopoverPresented = true
            }
            .colorPicker(isPresented: $isPopoverPresented, actionName: "Add", onAction: onAction)
    }
}

struct ColorPickerItem_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerItem { _ in }
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
