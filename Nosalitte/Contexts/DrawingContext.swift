//
//  File.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/09/02.
//

import PencilKit

class DrawingContext: ObservableObject {
    @Published var isPencilOnly: Bool
    @Published var cannotDraw = false
    @Published var mainTool: PKTool {
        willSet {
            tool = newValue
        }
    }
    
    var tool: PKTool
    
    init(tool: PKTool = PKInkingTool(.pen), isPencilOnly: Bool = false) {
        self.isPencilOnly = isPencilOnly
        self.mainTool = tool
        self.tool = tool
    }
}
