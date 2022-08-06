//
//  SubToolBar.swift
//  C-Note
//
//  Created by HotariTobu on 2021/08/10.
//

import SwiftUI

struct SubToolBar: View {
    @EnvironmentObject var noteContext: NoteContext
    @ObservedObject var deviceOrientation = DeviceOrientation()
    
    let isLeading: Bool
    
    var body: some View {
        Group {
            if deviceOrientation.isLandscape {
                HStack {
                    if !isLeading {
                        Spacer()
                    }
                    VStack {
                        icons
                    }
                    .frame(maxWidth: 60, maxHeight: .infinity)
                    .background(
                        Color.accentColor
                    )
                    if isLeading {
                        Spacer()
                    }
                }
            }
            else {
                VStack {
                    Spacer()
                    HStack {
                        icons
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(
                        Color.accentColor
                    )
                }
            }
        }
    }
    
    private var icons: some View {
        /*let tools = noteContext.subTools
        ForEach(tools.indices, id: \.self) { index in
            tools[index].icon
        }*/
        ForEach(noteContext.subTools.indices, id: \.self) { index in
            noteContext.subTools[index].icon
        }
    }
}

struct SubToolBar_Previews: PreviewProvider {
    static var previews: some View {
        SubToolBar(isLeading: true)
            .environmentObject(NoteContext())
            .environmentObject(DeviceOrientation())
    }
}

