//
//  GestureActionCenter.swift
//  iPhone
//
//  Created by HotariTobu on 2021/08/31.
//

import UIKit

class ActionCenter {
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

extension UISwipeGestureRecognizer.Direction: CustomStringConvertible {
    public var description: String {
        switch self {
        case .down:
            return "down"
        case .left:
            return "left"
        case .right:
            return "right"
        case .up:
            return "up"
        default:
            return ""
        }
    }
}
