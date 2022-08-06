//
//  NosalitteApp.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/08/11.
//

import SwiftUI

@main
struct NosalitteApp: App {
    var body: some Scene {
        WindowGroup {
            #if iPhone
            ContentView()
                .environmentObject(DeviceOrientation())
            #elseif iPad
            ContentView()
            #endif
        }
    }
}
