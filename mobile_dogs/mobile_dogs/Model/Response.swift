//
//  Response.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 31/05/23.
//

import Foundation

struct ListResponse: Codable {
    let message: [String: [String]]
    let status: String
}

struct SingleResponse: Codable {
    let message: String
    let status: String
}
