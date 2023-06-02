//
//  Storyboard+Intantiable.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 31/05/23.
//

import UIKit

extension StoryboardInstantiable where Self: UIViewController {
    static func fromStoryboard() -> Self {
        guard let name = description().components(separatedBy: ".").last?.replacingOccurrences(of: "ViewController", with: "") else {
            return Self.init(nibName: nil, bundle: nil)
        }
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        return initial as! Self
    }
}
