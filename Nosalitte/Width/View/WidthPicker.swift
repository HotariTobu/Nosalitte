//
//  WidthPicker.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/30.
//

import SwiftUI

struct WidthPicker: View {
    @Binding var width: CGFloat
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: width, height: 100)
            Slider(value: $width, in: 1 ... 100)
        }
        .padding()
    }
}

struct WidthPicker_Previews: PreviewProvider {
    static var previews: some View {
        WidthPicker(width: .constant(WidthElement.thin.width))
    }
}
