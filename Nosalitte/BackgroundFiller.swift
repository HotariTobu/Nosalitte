//
//  BackgroundFiller.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/17.
//

import SwiftUI

struct BackgroundFiller: View {
    let size: CGFloat
    
    var body: some View {
        GeometryReader {
            let columnCount = Int(ceil($0.size.width / size))
            let rowCount = Int(ceil($0.size.height / size))
            LazyVStack(spacing: 0) {
                ForEach(0 ..< rowCount) { row in
                    LazyHStack(spacing: 0) {
                        ForEach(0 ..< columnCount) { column in
                            (row % 2 == column % 2 ? Color.gray : Color.white)
                                .frame(width: size, height: size)
                        }
                    }
                }
            }
        }
    }
}

struct BackgroundFiller_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundFiller(size: 50)
    }
}
