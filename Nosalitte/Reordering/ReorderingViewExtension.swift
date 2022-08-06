//
//  ViewExtension.swift
//  iPhone
//
//  Created by HotariTobu on 2021/08/28.
//

import SwiftUI

extension View {
    func snapshot() -> UIImage {
        let _view = UIHostingController(rootView: self).view

        guard let view = _view else {
            return UIImage()
        }

        let targetSize = view.intrinsicContentSize
        view.bounds = CGRect(origin: .zero, size: targetSize)
        view.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }

    func reorderable<Data: ReorderableData>(data: Data, elementId: UUID) -> some View {
        self
            .opacity(data.draggingId == elementId ? 0 : 1)
            .overlay(
                ReorderingHost(data: data, elementId: elementId) {
                    self
                        .padding(10)
                        .snapshot()
                }
            )
    }
}
