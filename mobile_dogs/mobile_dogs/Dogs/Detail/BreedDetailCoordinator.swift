//
//  BreedDetailCoordinator.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 2/06/23.
//

import UIKit

class BreedDetailCoordinator: Coordinator {
    var presenter: UINavigationController
    var breed: Breed
    
    init(presenter: UINavigationController = UINavigationController(), breed: Breed) {
        self.presenter = presenter
        self.breed = breed
    }
    
    func navigate() {
        let controller = BreedDetailViewController()
        controller.viewModel = BreedViewModel(breed: breed)
        controller.coordinator = self
        presenter.pushViewController(controller, animated: true)
    }
}
