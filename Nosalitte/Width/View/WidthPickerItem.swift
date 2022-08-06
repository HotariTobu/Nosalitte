//
//  WidthPickerItem.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/30.
//

import SwiftUI

struct WidthPickerItem: View {
    @State private var isPopoverPresented = false
    
    let onAction: (WidthElement) -> Void
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 5)
            Circle()
                .stroke()
                .frame(width: 10)
            Circle()
                .stroke()
                .frame(width: 20)
            Circle()
                .stroke(lineWidth: 3)
                .frame(width: 40)
            Circle()
                .stroke(lineWidth: 5)
                .frame(width: 70)
            Circle()
                .stroke()
        }
        .onTapGesture {
            isPopoverPresented = true
        }
        .widthPicker(isPresented: $isPopoverPresented, actionName: "Add", onAction: onAction)
    }
}

struct WidthPickerItem_Previews: PreviewProvider {
    static var previews: some View {
        WidthPickerItem(onAction: { _ in })
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
