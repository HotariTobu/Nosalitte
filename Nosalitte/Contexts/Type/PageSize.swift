//
//  PageSize.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/09/05.
//

import UIKit

struct PageSize {
    let width: CGFloat
    let height: CGFloat
}

extension PageSize {
    static let A4 = PageSize(width: 210, height: 297)
    static let B5 = PageSize(width: 182, height: 257)
    static let Debug = PageSize(width: 700, height: 900)
}
