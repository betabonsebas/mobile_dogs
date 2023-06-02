//
//  BreedViewModel.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 1/06/23.
//

import Combine
import UIKit

class BreedViewModel: ObservableObject {
    let breed: Breed
    
    var name: String {
        breed.name
    }
    
    init(breed: Breed) {
        self.breed = breed
    }
    
    func fetchimage() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: breed.image)!)
            .map({ UIImage(data: $0.data) })
            .mapError({ $0 as Error })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
}
