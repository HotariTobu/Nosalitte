//
//  DeviceOrientationInfo.swift
//  iPhone
//
//  Created by HotariTobu on 2021/08/16.
//

import SwiftUI

final class DeviceOrientation: ObservableObject {
    @Published var isLandscape: Bool
    
    private var _observer: NSObjectProtocol?
    
    init() {
        isLandscape = UIDevice.current.orientation.isLandscape
        
        _observer = NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil) { [unowned self] note in
            guard let device = note.object as? UIDevice else {
                return
            }
            
            isLandscape = device.orientation.isLandscape
        }
    }
    
    deinit {
        if let observer = _observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
