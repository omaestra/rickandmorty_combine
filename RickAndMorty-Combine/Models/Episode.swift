//
//  Episode.swift
//  RickAndMorty-Combine
//
//  Created by omaestra on 16/6/21.
//

import Foundation

struct Episode: Codable {
    var id: Int
    var name: String
    var airDate: String
    var episode: String
    var characters: [String]
    var url: String
    var created: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        airDate = try container.decode(String.self, forKey: .airDate)
        episode = try container.decode(String.self, forKey: .episode)
        characters = try container.decode([String].self, forKey: .characters)
        url = try container.decode(String.self, forKey: .url)
        created = try container.decode(String.self, forKey: .created)
    }
}
