//
//  ReorderableElement.swift
//  iPhone
//
//  Created by HotariTobu on 2021/08/28.
//

import Foundation

protocol ReorderableElement: Identifiable, Equatable {
    var id: UUID { get }
}
