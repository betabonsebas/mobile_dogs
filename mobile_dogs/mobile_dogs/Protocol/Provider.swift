//
//  Provider.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 31/05/23.
//

import Combine
import Foundation

protocol Provider
{
  func fetch<T: Decodable>(api: API) -> AnyPublisher<T, Error>?
}
