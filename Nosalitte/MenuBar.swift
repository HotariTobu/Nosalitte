//
//  MenuBar.swift
//  C-Note
//
//  Created by HotariTobu on 2021/08/10.
//

import SwiftUI

struct MenuBar: View {
    @State var name = "Note Name"
    
    var body: some View {
        HStack() {
            Button(action: {
                
            }, label: {
                Image(systemName: "chevron.left")
            })
            .padding(10)
            
            TextField("NoteName", text: $name)
            
            MainToolBar()
            
            Menu(content: {
                Text("Test")
            }, label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            })
            .frame(width: 20)
            .padding()
        }
        .padding(.top, 10)
        .accentColor(.primary)
        .background(Color.accentColor)
        .frame(height: 70)
    }
}

struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuBar()
            .environmentObject(NoteContext())
    }
}
