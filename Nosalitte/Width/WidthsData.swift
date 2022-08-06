//
//  WidthsData.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/09/05.
//

import UIKit

class WidthsData: ReorderableData {
    @Published var array: [WidthElement]
    @Published var draggingId = UUID()
    
    init(widths: [CGFloat]) {
        self.array = widths.map {
            WidthElement(width: $0)
        }
    }
    
    subscript(id: UUID) -> WidthElement? {
        get {
            array.first {
                $0.id == id
            }
        }
        set {
            guard let newElement = newValue else {
                return
            }
            
            let _index = array.firstIndex {
                $0.id == id
            }
            
            if let index = _index {
                array.insert(newElement, at: index)
                array.remove(at: index + 1)
            }
            else {
                array.append(newElement)
            }
        }
    }
    
    func id(at index: Int) -> UUID {
        if array.indices.contains(index) {
            return array[index].id
        }
        
        return UUID()
    }
}

extension WidthsData {
    static let pen = WidthsData(widths: [5])
    static let marker = WidthsData(widths: [10])
}
