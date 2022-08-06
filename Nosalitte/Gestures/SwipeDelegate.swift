//
//  SwipeDelegate.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/09/01.
//

import UIKit

class SwipeDelegate: NSObject, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        gestureRecognizer.view == otherGestureRecognizer.view
    }
}
