//
//  PickingView.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/30.
//

import SwiftUI

struct PickingView<Data: ReorderableData, Item: View, Selector: View, Editor: View, Picker: View>: View {
    @ObservedObject var data: Data
    
    @Binding var selectedId: UUID
    
    let size: CGFloat
    let item: (Data.Element) -> Item
    let selector: () -> Selector
    let editor: (Binding<Bool>, Data.Element) -> Editor
    let picker: () -> Picker
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(data.array) { element in
                    PickingItemView(content: {
                        ZStack {
                            item(element)
                            
                            if selectedId == element.id {
                                selector()
                            }
                        }
                        .item(size: size)
                        .reorderable(data: data, elementId: element.id)
                        .contentShape(Circle())
                    }, editor: {
                        editor($0, element)
                    }, onDeleted: {
                        data.array.removeAll {
                            $0.id == element.id
                        }
                    })
                    .padding(5)
                    .onTapGesture {
                        selectedId = element.id
                    }
                }
                
                picker()
                    .item(size: size)
                    .overlay(
                        ZStack {
                            Circle()
                                .fill(Color.white)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .foregroundColor(.green)
                        }
                        .frame(width: 30, height: 30)
                        .position(x: size - 10, y: 10)
                    )
                    .padding(5)
            }
        }
        .frame(height: size + 50)
    }
}
