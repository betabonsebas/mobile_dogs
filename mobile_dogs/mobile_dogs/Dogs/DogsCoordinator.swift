//
//  DogsCoordinator.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 31/05/23.
//

import UIKit

class DogsCoordinator: Coordinator {
    var presenter: UINavigationController
    
    init(presenter: UINavigationController = UINavigationController()) {
        self.presenter = presenter
    }
    
    func navigate() {
        let controller = DogsViewController()
        controller.viewModel = DogsViewModel()
        controller.coordinator = self
        presenter.setViewControllers([controller], animated: false)
    }
}
