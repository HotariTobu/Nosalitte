//
//  ColorPickingView.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/17.
//

import SwiftUI

struct ColorPickingView: View {
    @Binding var selectedId: UUID
    
    let data: ColorsData
    
    var body: some View {
        PickingView(data: data, selectedId: $selectedId, size: 50, item: { element in
            element.color
        }, selector: {
            Circle()
                .stroke(Color.white, lineWidth: 3)
                .padding(5)
                .shadow(radius: 1)
        }, editor: { isPresented, element in
            ColorPickerPopover(isPresented: isPresented, colorElement: element.clone(), actionName: "Edit", onAction: {
                data[element.id] = $0
            })
        }, picker: {
            ColorPickerItem {
                data.array.append($0)
            }
        })
    }
}

struct ColorPickingView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickingView(selectedId: .constant(UUID()), data: .pen)
    }
}
