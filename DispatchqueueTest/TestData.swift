//
//  TestData.swift
//  DispatchqueueTest
//
//  Created by Yuki Shinohara on 2020/07/05.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation

class TestData {
    var id: Int?
    var title: String?
    var body: String?
    
    init(id: Int, title: String, body: String) {
        self.id = id
        self.title = title
        self.body = body
    }
}
