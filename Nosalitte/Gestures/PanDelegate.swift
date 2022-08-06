//
//  PanDelegate.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/31.
//

import UIKit

class PanDelegate: NSObject, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        gestureRecognizer.view == otherGestureRecognizer.view
    }
}
