//
//  InkData.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/09/05.
//

import Foundation

class InkData {
    let colorsData: ColorsData
    let widthsData: WidthsData
    
    init(colorsData: ColorsData, widthsData: WidthsData) {
        self.colorsData = colorsData
        self.widthsData = widthsData
    }
}

extension InkData {
    static let pen = InkData(colorsData: .pen, widthsData: .pen)
    static let marker = InkData(colorsData: .marker, widthsData: .marker)
}
