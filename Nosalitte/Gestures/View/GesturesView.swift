//
//  GesturesView.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/09/01.
//

import SwiftUI

struct GesturesView<Content: View>: UIViewControllerRepresentable {
    let actionCenter: ActionCenter
    let content: () -> Content
    
    func makeUIViewController(context: Context) -> UIHostingController<Content> {
        let uiViewController = UIHostingController(rootView: content())
        let _uiView = uiViewController.view
        
        guard let uiView = _uiView else {
            return uiViewController
        }
        
        uiView.backgroundColor = .clear
        uiView.isMultipleTouchEnabled = true
        
        let target = context.coordinator
        
        let taps = Array(repeatingWith: { UITapGestureRecognizer(target: target, action: #selector(Coordinator.tap(_:))) }, count: 9)
        let swipes = Array(repeatingWith: { UISwipeGestureRecognizer(target: target, action: #selector(Coordinator.swipe(_:))) }, count: 12)
        let longPresses = Array(repeatingWith: { UILongPressGestureRecognizer(target: target, action: #selector(Coordinator.longPress(_:))) }, count: 3)
        let pan = UIPanGestureRecognizer(target: target, action: #selector(Coordinator.pan(_:)))
        let pinch = UIPinchGestureRecognizer(target: target, action: #selector(Coordinator.pinch(_:)))
        let rotation = UIRotationGestureRecognizer(target: target, action: #selector(Coordinator.rotation(_:)))
        
        for (index, tap) in taps.enumerated() {
            let touchCount = index / 3 + 1
            let tapCount = index % 3 + 1
            tap.numberOfTouchesRequired = touchCount
            tap.numberOfTapsRequired = tapCount
            
            for index2 in (tapCount) ..< 3 {
                tap.require(toFail: taps[(touchCount - 1) * 3 + index2])
            }
            
            uiView.addGestureRecognizer(tap)
        }
        
        let directions: [UISwipeGestureRecognizer.Direction] = [.down, .left, .right, .up]
        for (index, swipe) in swipes.enumerated() {
            swipe.direction = directions[index / 3]
            swipe.numberOfTouchesRequired = index % 3 + 1
            
            uiView.addGestureRecognizer(swipe)
        }
        
        for (index, longPress) in longPresses.enumerated() {
            let touchCount = index + 1
            longPress.numberOfTouchesRequired = touchCount
            
            uiView.addGestureRecognizer(longPress)
        }
        
        pan.maximumNumberOfTouches = 3
        pan.delegate = target.panDelegate
        
        uiView.addGestureRecognizer(pan)
        uiView.addGestureRecognizer(pinch)
        uiView.addGestureRecognizer(rotation)
        
        return uiViewController
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: Context) {
        //uiViewController.rootView = content()
    }
    
    func makeCoordinator() -> ActionCenter {
        actionCenter
    }
}

/*extension GesturesView {
    class Coordinator {
        let panDelegate = PanDelegate()
        
        private let states = [
            "possible",
            "began",
            "changed",
            "ended",
            "cancelled",
            "failed",
        ]
        
        @objc func tap(_ sender: UITapGestureRecognizer) {
            print("tap \(sender.numberOfTouches) \(states[sender.state.rawValue]) \(sender.numberOfTapsRequired)")
        }
        
        @objc func swipe(_ sender: UISwipeGestureRecognizer) {
            print("swipe \(sender.numberOfTouches) \(states[sender.state.rawValue]) \(sender.direction)")
        }
        
        @objc func longPress(_ sender: UILongPressGestureRecognizer) {
            print("long press \(sender.numberOfTouches) \(states[sender.state.rawValue])")
        }
        
        @objc func pan(_ sender: UIPanGestureRecognizer) {
            print("pan \(sender.numberOfTouches) \(states[sender.state.rawValue])")
        }
        
        @objc func pinch(_ sender: UIPinchGestureRecognizer) {
            print("pinch \(sender.numberOfTouches) \(states[sender.state.rawValue]) \(sender.scale) \(sender.velocity)")
        }
        
        @objc func rotation(_ sender: UIRotationGestureRecognizer) {
            print("rotation \(sender.numberOfTouches) \(states[sender.state.rawValue]) \(sender.rotation) \(sender.velocity)")
        }
        
        @objc func edgePan(_ sender: UIScreenEdgePanGestureRecognizer) {
            print("edge pan \(states[sender.state.rawValue])")
        }
        
        @objc func hover(_ sender: UIHoverGestureRecognizer) {
            print("hover \(states[sender.state.rawValue])")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}*/

/*struct GesturesView<Content: View>: UIViewRepresentable {
    let content: () -> Content
    
    func makeUIView(context: Context) -> GesturesUIView {
        GesturesUIView()
    }
    
    func updateUIView(_ uiView: GesturesUIView, context: Context) {
        
    }
    
    typealias UIViewType = GesturesUIView
}*/

/*class GesturesUIView: UIView {
    private let actionCenter = ActionCenter()
    
    private let gestureDelegate = GestureDelegate()
    private let swipeDelegate = SwipeDelegate()
    private let panDelegate = PanDelegate()
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .clear
        self.isMultipleTouchEnabled = true
        
        let taps = Array(repeatingWith: { UITapGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.tap(_:))) }, count: 9)
        let swipes = Array(repeatingWith: { UISwipeGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.swipe(_:))) }, count: 12)
        let longPresses = Array(repeatingWith: { UILongPressGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.longPress(_:))) }, count: 3)
        let pan = UIPanGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.pan(_:)))
        let pinch = UIPinchGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.pinch(_:)))
        let rotation = UIRotationGestureRecognizer(target: actionCenter, action: #selector(GestureActionCenter.rotation(_:)))
        
        for (index, tap) in taps.enumerated() {
            let touchCount = index / 3 + 1
            let tapCount = index % 3 + 1
            tap.numberOfTouchesRequired = touchCount
            tap.numberOfTapsRequired = tapCount
            
            for index2 in (tapCount) ..< 3 {
                tap.require(toFail: taps[(touchCount - 1) * 3 + index2])
            }
            
            //tap.delegate = gestureDelegate
            
            self.addGestureRecognizer(tap)
        }
        
        let directions: [UISwipeGestureRecognizer.Direction] = [.down, .left, .right, .up]
        for (index, swipe) in swipes.enumerated() {
            swipe.direction = directions[index / 3]
            swipe.numberOfTouchesRequired = index % 3 + 1
            
            //swipe.delegate = gestureDelegate
            //swipe.delegate = swipeDelegate
            
            self.addGestureRecognizer(swipe)
        }
        
        for (index, longPress) in longPresses.enumerated() {
            let touchCount = index + 1
            longPress.numberOfTouchesRequired = touchCount
            
            //longPress.delegate = gestureDelegate
            
            self.addGestureRecognizer(longPress)
        }
        
        pan.maximumNumberOfTouches = 3
        //pan.delegate = panDelegate
        
        //pan.delegate = gestureDelegate
        //pinch.delegate = gestureDelegate
        //rotation.delegate = gestureDelegate
        
        self.addGestureRecognizer(pan)
        self.addGestureRecognizer(pinch)
        self.addGestureRecognizer(rotation)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
*/
