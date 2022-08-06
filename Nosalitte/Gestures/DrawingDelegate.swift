//
//  DrawingDelegate.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/09/01.
//

import UIKit

class DrawingDelegate: NSObject, UIGestureRecognizerDelegate {
    var canSimultaneously = true
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        canSimultaneously
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        gestureRecognizer.numberOfTouches == 1 && (otherGestureRecognizer is UISwipeGestureRecognizer || otherGestureRecognizer is UIPanGestureRecognizer)
    }
}
