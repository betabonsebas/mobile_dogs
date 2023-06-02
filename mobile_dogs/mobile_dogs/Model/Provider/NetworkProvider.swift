//
//  NetworkProvider.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 31/05/23.
//

import Combine
import Foundation

class NetworkProvider: Provider {
  func fetch<T>(api: API) -> AnyPublisher<T, Error>? where T: Decodable {
    do {
      let request = try api.asURLRequest()
      let anyCancellable = URLSession.shared.dataTaskPublisher(for: request)
        .map { $0.data }
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError({ $0 as Error })
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
      return anyCancellable
    } catch let error {
      print(error.localizedDescription)
      return nil
    }
  }
}
