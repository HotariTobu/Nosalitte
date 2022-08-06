//
//  ToolIconView.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/15.
//

import SwiftUI

struct ToolIconView: View {
    @EnvironmentObject var context: DrawingContext
    
    let isMain: Bool
    
    let onAction: () -> Void
    let onDown: () -> Void
    let onUp: () -> Void
    
    let frontPath: () -> Path
    let backPath: () -> Path
    let fillColor: () -> Color
    
    var body: some View {
        ZStack {
            if isMain {
                Color.backgroundColor
                    .onTapGesture(perform: onAction)
            }
            else {
                let tap = TapGesture(count: 2)
                    .onEnded(onAction)
                let longPress = LongPressGesture(minimumDuration: 0)
                    .onEnded { _ in
                        context.cannotDraw = true
                        onDown()
                    }
                let drag = DragGesture(minimumDistance: 0)
                    .onEnded { _ in
                        onUp()
                        context.cannotDraw = false
                    }
                
                Color.backgroundColor
                    .gesture(
                        SimultaneousGesture(tap, SimultaneousGesture(longPress, drag))
                    )
            }
            
            let transform = CGAffineTransform(scaleX: 50, y: 50)
            
            backPath()
                .transform(transform)
                .fill(fillColor())
            
            frontPath()
                .transform(transform)
                .stroke(Color.primary)
        }
        .frame(width: 50, height: 50)
        .clipShape(Circle())
        .contentShape(Circle())
        .shadow(radius: 4)
    }
}
