//
//  BreedDetailViewController.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 2/06/23.
//

import Combine
import UIKit

class BreedDetailViewController: UIViewController {
    
    private var subscriptions: Set<AnyCancellable> = []
    weak var breedImage: UIImageView!
    var viewModel: BreedViewModel!
    var coordinator: BreedDetailCoordinator!
    
    override func loadView() {
        super.loadView()
        
        let breedImage = UIImageView(frame: .zero)
        breedImage.translatesAutoresizingMaskIntoConstraints = false
        breedImage.clipsToBounds = true
        breedImage.contentMode = .scaleAspectFit
        view.addSubview(breedImage)
        
        NSLayoutConstraint.activate([
            breedImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            breedImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breedImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            breedImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.backgroundColor = .white
        
        self.breedImage = breedImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.name
        viewModel.fetchimage()
            .sink { completion in
                switch completion {
                case .finished:
                  break
                case .failure(let error):
                  print(error)
                }
            } receiveValue: { [weak self] image in
                self?.breedImage.image = image
            }
            .store(in: &subscriptions)
    }
}
