//
//  BreedViewModel.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 1/06/23.
//

import Foundation

class BreedViewModel: ObservableObject {
    let breed: Breed
    
    var name: String {
        breed.name
    }
    
    init(breed: Breed) {
        self.breed = breed
    }
}
