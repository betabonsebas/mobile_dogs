//
//  BreedCollectionViewCell.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 1/06/23.
//

import Combine
import UIKit

class BreedCollectionViewCell: UICollectionViewCell {
    
    private var subscriptions: Set<AnyCancellable> = []
    var viewModel: BreedViewModel!
    
    weak var imageView: UIImageView!
    weak var nameLabel: UILabel!
    weak var deleteButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
        
        let deleteButton = UIButton(type: .close)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        contentView.backgroundColor = .white
        self.imageView = imageView
        self.nameLabel = nameLabel
        self.deleteButton = deleteButton
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        imageView.image = nil
    }
    
    func setupViewModel(viewModel: BreedViewModel) {
        self.viewModel = viewModel
        setupUI()
    }
    
    func setupUI() {
        nameLabel.text = viewModel.name
        viewModel.fetchimage()
            .sink { completion in
                switch completion {
                case .finished:
                  break
                case .failure(let error):
                  print(error)
                }
            } receiveValue: { [weak self] image in
                self?.imageView.image = image
            }
            .store(in: &subscriptions)
    }
}
