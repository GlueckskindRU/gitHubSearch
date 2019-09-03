//
//  User.swift
//  gitHubSearch
//
//  Created by Yuri Ivashin on 03/09/2019.
//  Copyright © 2019 The Homber Team. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let author: String
    let avatarURL: URL
    let homePage: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case author = "login"
        case avatarURL = "avatar_url"
        case homePage = "html_url"
    }
}
