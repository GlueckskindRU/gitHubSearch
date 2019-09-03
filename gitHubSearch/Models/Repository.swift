//
//  Repository.swift
//  gitHubSearch
//
//  Created by Yuri Ivashin on 03/09/2019.
//  Copyright © 2019 The Homber Team. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let name: String
    let description: String?
    let owner: User
    let url: URL
    let language: String?
    let score: Double
    let stars: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case owner
        case url = "html_url"
        case language
        case score
        case stars = "stargazers_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.description = try values.decode(String?.self, forKey: .description)
        self.owner = try values.decode(User.self, forKey: .owner)
        self.url = try values.decode(URL.self, forKey: .url)
        self.language = try values.decode(String?.self, forKey: .language)
        self.score = try values.decode(Double.self, forKey: .score)
        self.stars = try values.decode(Int.self, forKey: .stars)
    }
}
