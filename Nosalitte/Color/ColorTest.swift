//
//  ColorTest.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/24.
//

import SwiftUI

struct ColorTest: View {
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    
    let colorData: [ColorData] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    
    var body: some View {
        ScrollView {
            HStack {
                LazyVStack {
                    ForEach(colors, id: \.self) {
                        Circle()
                            .fill($0)
                            .frame(width: 100, height: 100, alignment: .center)
                    }
                }
                LazyVStack {
                    ForEach(colorData) {
                        Circle()
                            .fill($0.color)
                            .frame(width: 100, height: 100, alignment: .center)
                    }
                }
            }
        }
    }
}

struct ColorTest_Previews: PreviewProvider {
    static var previews: some View {
        ColorTest()
    }
}
