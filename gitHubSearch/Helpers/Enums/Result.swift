//
//  Result.swift
//  gitHubSearch
//
//  Created by Yuri Ivashin on 03/09/2019.
//  Copyright © 2019 The Homber Team. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(SessionError)
}
