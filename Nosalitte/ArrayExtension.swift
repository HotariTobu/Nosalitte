//
//  ArrayExtension.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/31.
//

import Foundation

extension Array {
    init(repeatingWith repeatedClosure: () -> Array.Element, count: Int) {
        self.init()
        for _ in 0 ..< count {
            self.append(repeatedClosure())
        }
    }
}
