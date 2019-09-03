//
//  SearchRepositoriesResults.swift
//  gitHubSearch
//
//  Created by Yuri Ivashin on 03/09/2019.
//  Copyright © 2019 The Homber Team. All rights reserved.
//

import Foundation

struct SearchRepositoriesResults: Decodable {
    let totalFound: Int
    let repositories: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalFound = "total_count"
        case repositories = "items"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.totalFound = try values.decode(Int.self, forKey: .totalFound)
        self.repositories = try values.decode([Repository].self, forKey: .repositories)
    }
}
