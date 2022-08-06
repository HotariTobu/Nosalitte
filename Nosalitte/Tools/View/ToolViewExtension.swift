//
//  ViewExtension.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/17.
//

import SwiftUI

extension View {
    func toolPopover() -> some View {
        #if iPhone
        self
        #elseif iPad
        self
            .frame(width: 300)
        #endif
    }
    
    func item(size: CGFloat) -> some View {
        self
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}
