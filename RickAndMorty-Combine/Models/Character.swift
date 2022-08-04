//
//  Character.swift
//  RickAndMorty-Combine
//
//  Created by omaestra on 16/6/21.
//

import Foundation

struct Character: Codable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Location
    var location: Location
    var image: String
    var episode: [String]
    var url: String
    var created: String
}

struct CharacterData: Codable {
    var results: [Character]
}
