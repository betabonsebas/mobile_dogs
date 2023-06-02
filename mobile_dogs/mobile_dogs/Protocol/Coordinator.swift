//
//  Coordinator.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 31/05/23.
//

import UIKit

protocol Coordinator {
    var presenter: UINavigationController { get }
    
    func navigate()
}
