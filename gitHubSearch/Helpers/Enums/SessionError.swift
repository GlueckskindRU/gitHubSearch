//
//  SessionError.swift
//  gitHubSearch
//
//  Created by Yuri Ivashin on 03/09/2019.
//  Copyright © 2019 The Homber Team. All rights reserved.
//

import Foundation

enum SessionError: Error {
    case requestError
    case dataError
    case otherError(Error)
    
    func getError() -> String {
        switch self {
        case .requestError
            return "Error with creating a network request"
        case .dataError:
            return "Error with decoding received data"
        case .otherError(let error):
            return error.localizedDescription
        }
    }
}
