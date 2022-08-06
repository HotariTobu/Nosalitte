//
//  DrawingView.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/11.
//

import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    @EnvironmentObject var drawingContext: DrawingContext
    
    func makeUIView(context: Context) -> PKCanvasView {
        let uiView = PKCanvasView()
        
        uiView.backgroundColor = .clear
        uiView.isMultipleTouchEnabled = true
        
        uiView.drawingGestureRecognizer.delegate = context.coordinator
        
        return uiView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = self.drawingContext.tool
        uiView.drawingPolicy = self.drawingContext.isPencilOnly ? .pencilOnly : .anyInput
        if !self.drawingContext.isPencilOnly {
            context.coordinator.canSimultaneously = self.drawingContext.cannotDraw
        }
    }
    
    func makeCoordinator() -> DrawingDelegate {
        DrawingDelegate()
    }
}
