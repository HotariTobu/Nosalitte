//
//  PnecilTool.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/09/01.
//

import PencilKit
import SwiftUI

struct PencilTool: View, Tool {
    @EnvironmentObject var noteContext: NoteContext
    @EnvironmentObject var drawingContext: DrawingContext
    
    @Binding var colorId: UUID
    @Binding var widthId: UUID
    
    @State private var isPopoverPresented = false
    
    let isMain: Bool
    
    private var color: Color {
        noteContext.pencilData.colorsData[colorId]?.color ?? .clear
    }
    
    private var width: CGFloat {
        noteContext.pencilData.widthsData[widthId]?.width ?? 1
    }
    
    var body: some View {
        ToolIconView(isMain: isMain, onAction: {
            isPopoverPresented = true
        }, onDown: {
            drawingContext.tool = PKInkingTool(.pencil, color: UIColor(color), width: width)
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
                
                path.move(to: CGPoint(x: 0.3, y: 0.4))
                path.addLine(to: CGPoint(x: 0.5, y: 0.0))
                path.addLine(to: CGPoint(x: 0.7, y: 0.4))
            }
        }, backPath: {
            Path { path in
                path.move(to: CGPoint(x: 0.1, y: 1))
                path.addLine(to: CGPoint(x: 0.1, y: 0.8))
                path.addLine(to: CGPoint(x: 0.9, y: 0.8))
                path.addLine(to: CGPoint(x: 0.9, y: 1))
                
                path.move(to: CGPoint(x: 0.3, y: 0.4))
                path.addLine(to: CGPoint(x: 0.5, y: 0.0))
                path.addLine(to: CGPoint(x: 0.7, y: 0.4))
            }
        }, fillColor: {
            color
        })
        .popover(isPresented: $isPopoverPresented) {
            VStack {
                Spacer()
                GroupBox(label: Text("ToolWidth"), content: {
                    WidthPickingView(selectedId: $widthId, data: noteContext.pencilData.widthsData)
                })
                GroupBox(label: Text("ToolColor"), content: {
                    ColorPickingView(selectedId: $colorId, data: noteContext.pencilData.colorsData)
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
            drawingContext.mainTool = PKInkingTool(.pencil, color: UIColor(color), width: width)
        }
    }
    
    var icon: AnyView {
        AnyView(self)
    }
}

extension PencilTool {
    static let sample = PencilTool(colorId: .constant(UUID()), widthId: .constant(UUID()), isMain: true)
    static let sample2 = PencilTool(colorId: .constant(UUID()), widthId: .constant(UUID()), isMain: false)
}

struct PencilTool_Previews: PreviewProvider {
    static var previews: some View {
        PencilTool.sample
            .environmentObject(NoteContext())
            .environmentObject(DrawingContext())
            .background(Color.accentColor)
            .previewLayout(.fixed(width: 50, height: 50))
    }
}

