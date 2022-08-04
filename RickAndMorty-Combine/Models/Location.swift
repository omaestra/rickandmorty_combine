//
//  Location.swift
//  RickAndMorty-Combine
//
//  Created by omaestra on 16/6/21.
//

import Foundation

struct Location: Codable {
    var id: Int?
    var name: String?
    var type: String?
    var dimension: String?
    var residents: [String]?
    var url: String?
    var created: String?
}
