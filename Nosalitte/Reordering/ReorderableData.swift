//
//  ReorderableData.swift
//  iPhone
//
//  Created by HotariTobu on 2021/08/28.
//

import Foundation

protocol ReorderableData: ObservableObject {
    associatedtype Element: ReorderableElement
    var array: [Element] { get set }
    var draggingId: UUID { get set }
}
