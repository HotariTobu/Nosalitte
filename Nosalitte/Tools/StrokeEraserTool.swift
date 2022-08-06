//
//  StrokeEraserTool.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/09/01.
//

import PencilKit
import SwiftUI

struct StrokeEraserTool: View, Tool {
    @EnvironmentObject var drawingContext: DrawingContext
    
    let isMain: Bool
    
    var body: some View {
        ToolIconView(isMain: isMain, onAction: {
            
        }, onDown: {
            drawingContext.tool = PKEraserTool(.vector)
        }, onUp: {
            drawingContext.tool = drawingContext.mainTool
        }, frontPath: {
            Path { path in
                path.move(to: CGPoint(x: 0.1, y: 1))
                path.addLine(to: CGPoint(x: 0.1, y: 0.6))
                path.addLine(to: CGPoint(x: 0.9, y: 0.6))
                path.addLine(to: CGPoint(x: 0.9, y: 1))
                
                path.move(to: CGPoint(x: 0.1, y: 0.6))
                path.addLine(to: CGPoint(x: 0.2, y: 0.2))
                path.addLine(to: CGPoint(x: 0.8, y: 0.4))
                path.addLine(to: CGPoint(x: 0.9, y: 0.6))
            }
        }, backPath: {
            Path { path in
                path.move(to: CGPoint(x: 0.1, y: 1))
                path.addLine(to: CGPoint(x: 0.1, y: 0.6))
                path.addLine(to: CGPoint(x: 0.9, y: 0.6))
                path.addLine(to: CGPoint(x: 0.9, y: 1))
            }
        }, fillColor: {
            .pink
        })
        .onAppear {
            updateMainTool()
        }
    }
    
    private func updateMainTool() {
        if isMain {
            drawingContext.mainTool = PKEraserTool(.vector)
        }
    }
    
    var icon: AnyView {
        AnyView(self)
    }
}

extension StrokeEraserTool {
    static let sample = StrokeEraserTool(isMain: true)
    static let sample2 = StrokeEraserTool(isMain: false)
}

struct StrokeEraserTool_Previews: PreviewProvider {
    static var previews: some View {
        StrokeEraserTool.sample
            .environmentObject(DrawingContext())
            .background(Color.accentColor)
            .previewLayout(.fixed(width: 50, height: 50))
    }
}
