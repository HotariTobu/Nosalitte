//
//  ContentView.swift
//  C-Note
//
//  Created by HotariTobu on 2021/08/08.
//

import SwiftUI

struct ContentView: View {
    @State private var penColorId = ColorsData.pen.id(at: 0)
    @State private var penWidthId = WidthsData.pen.id(at: 0)
    @State private var pencilColorId = ColorsData.pen.id(at: 0)
    @State private var pencilWidthId = WidthsData.pen.id(at: 0)
    @State private var markerColorId = ColorsData.marker.id(at: 0)
    @State private var markerWidthId = WidthsData.marker.id(at: 0)
    
    var body: some View {
        let noteContext = NoteContext(mainTool: PenTool(colorId: $penColorId, widthId: $penWidthId, isMain: true), subTools: [PencilTool(colorId: $pencilColorId, widthId: $pencilWidthId, isMain: false), MarkerTool(colorId: $markerColorId, widthId: $markerWidthId, isMain: false), CircleEraserTool(isMain: false), StrokeEraserTool(isMain: false)])
        NoteView(noteContext: noteContext, drawingContext: DrawingContext(isPencilOnly: false))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        #if iPhone
        ContentView()
            .environmentObject(NoteContext())
            .environmentObject(DrawingContext())
            .environmentObject(DeviceOrientation())
        #elseif iPad
        ContentView()
            .environmentObject(NoteContext())
            .environmentObject(DrawingContext())
        #endif
    }
}
