//
//  UIEventWrapperView.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/24.
//

import SwiftUI

struct UIEventWrapperView: UIViewRepresentable {
    let recognizers: [UIGestureRecognizer]
    
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        for recognizer in recognizers {
            view.addGestureRecognizer(recognizer)
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
