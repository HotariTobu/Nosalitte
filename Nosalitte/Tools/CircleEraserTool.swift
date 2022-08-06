//
//  EraserTool.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/09/01.
//

import PencilKit
import SwiftUI

struct CircleEraserTool: View, Tool {
    @EnvironmentObject var drawingContext: DrawingContext
    
    let isMain: Bool
    
    var body: some View {
        ToolIconView(isMain: isMain, onAction: {
            
        }, onDown: {
            drawingContext.tool = PKEraserTool(.bitmap)
        }, onUp: {
            drawingContext.tool = drawingContext.mainTool
        }, frontPath: {
            Path { path in
                path.move(to: CGPoint(x: 0.1, y: 1))
                path.addLine(to: CGPoint(x: 0.1, y: 0.6))
                path.addLine(to: CGPoint(x: 0.9, y: 0.6))
                path.addLine(to: CGPoint(x: 0.9, y: 1))
                
                path.move(to: CGPoint(x: 0.1, y: 0.6))
                path.addCurve(to: CGPoint(x: 0.9, y: 0.6), control1: CGPoint(x: 0.2, y: 0.1), control2: CGPoint(x: 0.8, y: 0.1))
            }
        }, backPath: {
            Path { path in
                path.move(to: CGPoint(x: 0.1, y: 1))
                path.addLine(to: CGPoint(x: 0.1, y: 0.6))
                path.addLine(to: CGPoint(x: 0.9, y: 0.6))
                path.addLine(to: CGPoint(x: 0.9, y: 1))
            }
        }, fillColor: {
            .blue
        })
        .onAppear {
            updateMainTool()
        }
    }
    
    private func updateMainTool() {
        if isMain {
            drawingContext.mainTool = PKEraserTool(.bitmap)
        }
    }
    
    var icon: AnyView {
        AnyView(self)
    }
}

extension CircleEraserTool {
    static let sample = CircleEraserTool(isMain: true)
    static let sample2 = CircleEraserTool(isMain: false)
}

struct CircleEraserTool_Previews: PreviewProvider {
    static var previews: some View {
        CircleEraserTool.sample
            .environmentObject(DrawingContext())
            .background(Color.accentColor)
            .previewLayout(.fixed(width: 50, height: 50))
    }
}
