//
//  SubToolBar.swift
//  C-Note
//
//  Created by HotariTobu on 2021/08/10.
//

import SwiftUI

struct SubToolBar: View {
    @EnvironmentObject var noteContext: NoteContext
    @EnvironmentObject var drawingContext: DrawingContext
    
    @Binding var position: UnitPoint
    
    @State private var size = CGSize()
    @State private var isDragging = false
    @State private var offset: CGSize = .zero
    @State private var computedPosition: CGPoint = .zero
    
    @State private var isHorizontal = true
    
    var body: some View {
        GeometryReader { proxy in
            let longPress = LongPressGesture()
                .onChanged { _ in
                    drawingContext.cannotDraw = true
                }
                .onEnded { _ in
                    withAnimation {
                        isDragging = true
                    }
                }
            let drag = DragGesture(minimumDistance: 0)
                .onChanged {
                    if isDragging {
                        offset = $0.translation
                    }
                }
                .onEnded {
                    drawingContext.cannotDraw = false
                    if isDragging {
                        applyTranslation(containerSize: proxy.size, translation: $0.translation)
                        
                        withAnimation {
                            isDragging = false
                        }
                        offset = .zero
                    }
                }
            
            Group {
                if isHorizontal {
                    HStack {
                        icons
                    }
                    .frame(height: 60)
                }
                else {
                    VStack {
                        icons
                    }
                    .frame(width: 60)
                }
            }
            .padding(isHorizontal ? .horizontal : .vertical, 5)
            .background(
                GeometryReader { childProxy in
                    Color.accentColor
                        .onAppear {
                            size = childProxy.size
                            updateIsHorizontal()
                        }
                }
            )
            .clipShape(Capsule())
            .contentShape(Capsule())
            .shadow(radius: isDragging ? 10 : 0)
            .zIndex(isDragging ? 1 : 0)
            .offset(offset)
            .position(computedPosition)
            .gesture(SimultaneousGesture(longPress, drag))
            .onChange(of: position) { _ in
                computePosition(containerSize: proxy.size)
                updateIsHorizontal()
            }
            .onChange(of: size) { _ in
                computePosition(containerSize: proxy.size)
            }
        }
    }
    
    private var icons: some View {
        Group {
            let tools = noteContext.subTools
            ForEach(tools.indices, id: \.self) { index in
                tools[index].icon
            }
            
            Image(systemName: "slash.circle")
                .resizable()
                .foregroundColor(.backgroundColor)
                .padding(10)
                .frame(width: 50, height: 50)
        }
    }
    
    private func updateIsHorizontal() {
        isHorizontal = (0 ... 1).contains(position.x)
    }
    
    private func computePosition(containerSize: CGSize) {
        let y = (containerSize.height - size.height) * position.y + size.height / 2
        
        if position.x < 0 {
            computedPosition =  CGPoint(x: size.width / 2, y: y)
        }
        else if position.x > 1 {
            computedPosition =  CGPoint(x: containerSize.width - size.width / 2, y: y)
        }
        else {
            computedPosition =  CGPoint(x: (containerSize.width - size.width) * position.x + size.width / 2, y: y)
        }
    }
    
    private func applyTranslation(containerSize: CGSize, translation: CGSize) {
        let staticLength = isHorizontal ? size.height : size.width
        let dynamicLength = isHorizontal ? size.width : size.height
        
        let location = computedPosition + translation
        let rectX = dynamicLength / 2
        let rectWidth = containerSize.width - dynamicLength
        
        let x = location.x - rectX
        let unitX = x / rectWidth
        
        let verticalPadding = (0 ... 1).contains(unitX) ? staticLength : dynamicLength
        
        let rectY = verticalPadding / 2
        let rectHeight = containerSize.height - verticalPadding
        
        var y = location.y - rectY
        
        if y < 0 {
            y = 0
        }
        else if y > rectHeight {
            y = rectHeight
        }
        
        let unitY = y / rectHeight
        
        position = UnitPoint(x: unitX, y: unitY)
    }
}

extension CGPoint {
    static func + (left: CGPoint, right: CGSize) -> CGPoint {
        CGPoint(x: left.x + right.width, y: left.y + right.height)
    }
}

struct SubToolBar_Previews: PreviewProvider {
    static var previews: some View {
        SubToolBar(position: .constant(UnitPoint(x: -1.5, y: 0.5)))
            .environmentObject(NoteContext())
    }
}

