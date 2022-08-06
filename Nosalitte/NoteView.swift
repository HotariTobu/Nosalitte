//
//  NoteView.swift
//  C-Note
//
//  Created by HotariTobu on 2021/08/08.
//

import SwiftUI

struct NoteView: View {
    @ObservedObject var noteContext: NoteContext
    @ObservedObject var drawingContext: DrawingContext
    
    @State private var pageContext = PageContext()
    
    #if iPad
    @State private var subToolBarPosition = UnitPoint(x: -0.5, y: 0.5)
    #endif
    
    var body: some View {
        VStack(spacing: 0) {
            MenuBar()
                .zIndex(0.1)
            
            ZStack {
                GesturesView(actionCenter: ActionCenter()) {
                    ZStack {
                        BackgroundFiller(size: 30)
                        PageView(pageContext: PageContext(pageSize: .Debug))
                            //.scaleEffect(x: 3, y: 3)
                    }
                }
                
                #if iPhone
                SubToolBar(isLeading: true)
                #elseif iPad
                SubToolBar(position: $subToolBarPosition)
                #endif
            }
        }
        .ignoresSafeArea()
        .shadow(radius: 10)
        .environmentObject(noteContext)
        .environmentObject(drawingContext)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(noteContext: NoteContext(), drawingContext: DrawingContext())
    }
}
