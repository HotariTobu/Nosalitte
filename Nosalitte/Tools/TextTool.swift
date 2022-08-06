//
//  TextTool.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/17.
//

import SwiftUI

struct TextTool: View, Tool {
    var body: some View {
        ToolIconView(isMain: false, onAction: {
            
        }, onDown: {
            
        }, onUp: {
            
        }, frontPath: {
            Path()
        }, backPath: {
            Path { path in
                path.move(to: CGPoint(x: 0.2, y: 0.1))
                path.addLine(to: CGPoint(x: 0.8, y: 0.1))
                path.addLine(to: CGPoint(x: 0.85, y: 0.3))
                path.addArc(center: CGPoint(x: 0.7, y: 0.25), radius: 0.1, startAngle: .zero, endAngle: .degrees(-90), clockwise: true)
                path.addArc(center: CGPoint(x: 0.65, y: 0.25), radius: 0.1, startAngle: .degrees(-90), endAngle: .degrees(180), clockwise: true)
                path.addArc(center: CGPoint(x: 0.65, y: 0.85), radius: 0.1, startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
                path.addLine(to: CGPoint(x: 0.65, y: 0.98))
                path.addLine(to: CGPoint(x: 0.35, y: 0.98))
                path.addLine(to: CGPoint(x: 0.35, y: 0.9))
                path.addArc(center: CGPoint(x: 0.35, y: 0.85), radius: 0.1, startAngle: .degrees(90), endAngle: .zero, clockwise: true)
                path.addLine(to: CGPoint(x: 0.45, y: 0.3))
                path.addArc(center: CGPoint(x: 0.35, y: 0.25), radius: 0.1, startAngle: .zero, endAngle: .degrees(-90), clockwise: true)
                path.addArc(center: CGPoint(x: 0.3, y: 0.25), radius: 0.1, startAngle: .degrees(-90), endAngle: .degrees(180), clockwise: true)
                path.addLine(to: CGPoint(x: 0.15, y: 0.3))
                path.closeSubpath()
            }
        }, fillColor: {
            .primary
        })
    }
    
    var icon: AnyView {
        AnyView(self)
    }
}

struct TextTool_Previews: PreviewProvider {
    static var previews: some View {
        TextTool()
            .environmentObject(NoteContext())
            .background(Color.accentColor)
            .previewLayout(.fixed(width: 50, height: 50))
    }
}

