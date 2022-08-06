//
//  WidthPickingView.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/29.
//

import SwiftUI

struct WidthPickingView: View {
    @Binding var selectedId: UUID
    
    let data: WidthsData
    
    var body: some View {
        PickingView(data: data, selectedId: $selectedId, size: 100, item: { element in
                Circle()
                    .frame(width: element.width)
            }, selector: {
                Circle()
                    .stroke(Color.white, lineWidth: 3)
                    .padding(5)
                    .shadow(radius: 1)
            }, editor: { isPresented, element in
                WidthPickerPopover(isPresented: isPresented, widthElement: element, actionName: "Edit", onAction: {
                    data[element.id] = $0
                    if selectedId == element.id {
                        selectedId = $0.id
                    }
                })
            }, picker: {
                WidthPickerItem {
                    data.array.append($0)
                }
            })
    }
}

struct WidthPickingView_Previews: PreviewProvider {
    static var previews: some View {
        WidthPickingView(selectedId: .constant(UUID()), data: .pen)
    }
}

