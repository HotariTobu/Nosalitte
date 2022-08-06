//
//  ReorderingHost.swift
//  iPhone
//
//  Created by HotariTobu on 2021/08/28.
//

import SwiftUI

struct ReorderingHost<Data: ReorderableData>: UIViewRepresentable {
    typealias UIViewType = ReorderingDnDHost

    let data: Data
    let elementId: UUID
    let onSnapshot: () -> UIImage

    func makeUIView(context: Context) -> ReorderingDnDHost {
        ReorderingDnDHost(onDragBegun: {
            data.draggingId = elementId
        }, onDragEnded: {
            data.draggingId = UUID()
        }, onDropEntered: {
            guard data.draggingId != elementId else {
                return
            }

            let _from = data.array.firstIndex {
                $0.id == data.draggingId
            }
            let _to = data.array.firstIndex {
                $0.id == elementId
            }

            guard let from = _from, let to = _to else {
                return
            }

            withAnimation {
                data.array.move(fromOffsets: IndexSet(integer: from), toOffset: to + (from < to ? 1 : 0))
            }
        })
    }

    func updateUIView(_ uiView: ReorderingDnDHost, context: Context) {
        uiView.onSnapshot = onSnapshot
    }
}
