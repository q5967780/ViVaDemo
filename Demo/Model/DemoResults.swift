//
//  DemoResults.swift
//  Demo
//
//  Created by CLships on 2024/6/10.
//

import UIKit

struct DemoResults: Codable {
    struct DataList: Codable {
        struct DataProduct: Codable {
            var albumId: Int
            var id: Int
            var title: String
            var url: String
            var thumbnailUrl: String
        }
        var albumId: Int
        var id: Int
        var title: String
        var url: String
        var thumbnailUrl: String
        var product: [DataProduct]?
    }
    var data: [DataList]
}
