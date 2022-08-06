//
//  WidthData.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/29.
//

import SwiftUI

struct WidthElement: ReorderableElement {
    let id = UUID()
    var width: CGFloat
}

extension WidthElement {
    static let thin = WidthElement(width: 3)
    static let bold = WidthElement(width: 10)
}
