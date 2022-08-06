//
//  PageView.swift
//  C-Note
//
//  Created by HotariTobu on 2021/08/10.
//

import SwiftUI

struct PageView: View {
    @ObservedObject var pageContext: PageContext
    
    var body: some View {
        ZStack {
            Color.backgroundColor
            DrawingView()
        }
        .frame(width: pageContext.pageSize.width, height: pageContext.pageSize.height)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pageContext: PageContext())
            .environmentObject(NoteContext())
            .environmentObject(DrawingContext())
    }
}
