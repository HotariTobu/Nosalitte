//
//  Pen.swift
//  C-Note
//
//  Created by HotariTobu on 2021/08/10.
//

import PencilKit
import SwiftUI

struct PenTool: View, Tool {
    @EnvironmentObject var noteContext: NoteContext
    @EnvironmentObject var drawingContext: DrawingContext
    
    @Binding var colorId: UUID
    @Binding var widthId: UUID
    
    @State private var isPopoverPresented = false
    
    let isMain: Bool
    
    private var color: Color {
        noteContext.penData.colorsData[colorId]?.color ?? .clear
    }
    
    private var width: CGFloat {
        noteContext.penData.widthsData[widthId]?.width ?? 1
    }
    
    var body: some View {
        ToolIconView(isMain: isMain, onAction: {
            isPopoverPresented = true
        }, onDown: {
            drawingContext.tool = PKInkingTool(.pen, color: UIColor(color), width: width)
        }, onUp: {
            drawingContext.tool = drawingContext.mainTool
        }, frontPath: {
            Path { path in
                path.move(to: CGPoint(x: 0.1, y: 1))
                path.addLine(to: CGPoint(x: 0.1, y: 0.8))
                path.addLine(to: CGPoint(x: 0.9, y: 0.8))
                path.addLine(to: CGPoint(x: 0.9, y: 1))
                
                path.move(to: CGPoint(x: 0.1, y: 0.8))
                path.addLine(to: CGPoint(x: 0.3, y: 0.4))
                path.addLine(to: CGPoint(x: 0.7, y: 0.4))
                path.addLine(to: CGPoint(x: 0.9, y: 0.8))
                
                path.move(to: CGPoint(x: 0.35, y: 0.4))
                path.addCurve(to: CGPoint(x: 0.65, y: 0.4), control1: CGPoint(x: 0.4, y: -0.1), control2: CGPoint(x: 0.6, y: -0.1))
            }
        }, backPath: {
            Path { path in
                path.move(to: CGPoint(x: 0.1, y: 1))
                path.addLine(to: CGPoint(x: 0.1, y: 0.8))
                path.addLine(to: CGPoint(x: 0.9, y: 0.8))
                path.addLine(to: CGPoint(x: 0.9, y: 1))
                
                path.move(to: CGPoint(x: 0.35, y: 0.4))
                path.addCurve(to: CGPoint(x: 0.65, y: 0.4), control1: CGPoint(x: 0.4, y: -0.1), control2: CGPoint(x: 0.6, y: -0.1))
            }
        }, fillColor: {
            color
        })
        .popover(isPresented: $isPopoverPresented) {
            VStack {
                Spacer()
                GroupBox(label: Text("ToolWidth"), content: {
                    WidthPickingView(selectedId: $widthId, data: noteContext.penData.widthsData)
                })
                GroupBox(label: Text("ToolColor"), content: {
                    ColorPickingView(selectedId: $colorId, data: noteContext.penData.colorsData)
                })
            }
            .toolPopover()
            .padding()
        }
        .onChange(of: isPopoverPresented) {
            if !$0 {
                updateMainTool()
            }
        }
        .onAppear {
            updateMainTool()
        }
    }
    
    private func updateMainTool() {
        if isMain {
            drawingContext.mainTool = PKInkingTool(.pen, color: UIColor(color), width: width)
        }
    }
    
    var icon: AnyView {
        AnyView(self)
    }
}

extension PenTool {
    static let sample = PenTool(colorId: .constant(UUID()), widthId: .constant(UUID()), isMain: true)
    static let sample2 = PenTool(colorId: .constant(UUID()), widthId: .constant(UUID()), isMain: false)
}

struct PenTool_Previews: PreviewProvider {
    static var previews: some View {
        PenTool.sample
            .environmentObject(NoteContext())
            .environmentObject(DrawingContext())
            .background(Color.accentColor)
            .previewLayout(.fixed(width: 50, height: 50))
    }
}

