//
//  PickingItemView.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/29.
//

import SwiftUI

struct PickingItemView<Content: View, Editor: View>: View {
    @State private var isEditing = false
    @State private var isDeleting = false
    
    let content: () -> Content
    let editor: (Binding<Bool>) -> Editor
    let onDeleted: () -> Void
    
    var body: some View {
        content()
            .contextMenu(ContextMenu {
                Button("Edit") {
                    isEditing = true
                }
                Button(action: {
                    isDeleting = true
                }, label: {
                    Text("Delete")
                        .foregroundColor(.red)
                    Image(systemName: "trash")
                })
            })
            .popover(isPresented: $isEditing) {
                editor($isEditing)
            }
            .actionSheet(isPresented: $isDeleting) {
                ActionSheet(title: Text("ConfirmDelete"), message: nil, buttons: [.destructive(Text("Delete")) {
                    onDeleted()
                }, .cancel()])
            }
    }
}
