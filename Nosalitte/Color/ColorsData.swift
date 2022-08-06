//
//  ColorsData.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/09/05.
//

import Foundation

class ColorsData: ReorderableData {
    @Published var array: [ColorElement]
    @Published var draggingId = UUID()
    
    init(colors: [ColorElement]) {
        self.array = colors
    }
    
    subscript(id: UUID) -> ColorElement? {
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

extension ColorsData {
    static let pen = ColorsData(colors: [.black, .red, .blue, .green, .orange])
    static let marker = ColorsData(colors: [.yellow, .cyan, .purple])
}
