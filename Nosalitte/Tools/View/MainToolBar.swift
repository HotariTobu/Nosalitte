//
//  MainToolBar.swift
//  C-Note
//
//  Created by HotariTobu on 2021/08/10.
//

import SwiftUI

struct MainToolBar: View {
    @EnvironmentObject var noteContext: NoteContext
    
    var body: some View {
        HStack {
            icon(tool: noteContext.mainTool, editMode: .Drawing)
            Divider()
            icon(tool: TextTool(), editMode: .Text)
        }
    }
    
    private func icon(tool: Tool, editMode: NoteEditMode) -> some View {
        let isEnable = noteContext.editMode == editMode
        return tool.icon
            .opacity(isEnable ? 1 : 0.2)
            .allowsHitTesting(isEnable)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    noteContext.editMode = editMode
                }
            }
    }
}

struct MainToolBar_Previews: PreviewProvider {
    static var previews: some View {
        MainToolBar()
            .environmentObject(NoteContext())
            .background(Color.accentColor)
    }
}
