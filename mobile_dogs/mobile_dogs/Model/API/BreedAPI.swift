//
//  BreedAPI.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 1/06/23.
//

import Foundation

enum BreedAPI: API {
    
    case allBreeds
    case randomBreed
    case breed(String)
    
    var requestMethod: String {
        "GET"
    }
    
    var requestPath: String? {
        switch self {
        case .allBreeds:
            return "/api/breeds/list/all"
        case .randomBreed:
            return "/api/breeds/image/random"
        case .breed(let text):
            return "/api/breed/\(text)/images/random"
        }
    }
    
    var requestPathParam: String? {
        nil
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
}
