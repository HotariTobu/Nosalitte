//
//  Context.swift
//  C-Note
//
//  Created by HotariTobu on 2021/08/10.
//

import UIKit

class NoteContext: ObservableObject {
    @Published var editMode: NoteEditMode
    @Published var direction: NoteDirection
    @Published var pageInterval: CGFloat
    @Published var pageSet: PageSet
    
    @Published var mainTool: Tool
    @Published var subTools: [Tool]
    
    let penData: InkData
    let pencilData: InkData
    let markerData: InkData
    
    init(editMode: NoteEditMode = .Drawing, direction: NoteDirection = .horizontal, pageInterval: CGFloat = 50, pageSet: PageSet = .single, mainTool: Tool = PenTool.sample, subTools: [Tool] = [PencilTool.sample2, MarkerTool.sample2, CircleEraserTool.sample2, StrokeEraserTool.sample2], penData: InkData = .pen, pencilData: InkData = .pen, markerData: InkData = .marker) {
        self.editMode = editMode
        self.direction = direction
        self.pageInterval = pageInterval
        self.pageSet = pageSet
        
        self.mainTool = mainTool
        self.subTools = subTools
        
        self.penData = penData
        self.pencilData = pencilData
        self.markerData = markerData
    }
}
