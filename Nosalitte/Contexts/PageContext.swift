//
//  PageContext.swift
//  Nosalitte
//
//  Created by HotariTobu on 2021/09/05.
//

import Foundation

class PageContext: ObservableObject {
    @Published var pageSize: PageSize
    
    init(pageSize: PageSize = .A4) {
        self.pageSize = pageSize
    }
}
