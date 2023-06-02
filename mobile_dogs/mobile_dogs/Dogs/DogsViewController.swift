//
//  ViewController.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 31/05/23.
//

import Combine
import UIKit

class DogsViewController: UIViewController, StoryboardInstantiable {
    
    private struct Constants {
        static let cellIdentifier = "breedCell"
    }
    
    private var subscriptions: Set<AnyCancellable> = []
    
    var coordinator: DogsCoordinator!
    var viewModel: DogsViewModel!
    weak var collectionView: UICollectionView!
    var searchController: UISearchController!
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .white
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        collectionView.backgroundColor = .lightGray
        self.collectionView = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        initSearchController()
        configureCollectionView()
        viewModel.$isSearching
            .sink { [weak self] isSearching in
                if let isSearching = isSearching, !isSearching {
                    self?.searchController.isActive = isSearching
                    self?.searchController.dismiss(animated: true)
                }
            }
            .store(in: &subscriptions)
        viewModel.$breeds
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Initialization & configuration
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BreedCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func initSearchController() {
        let resultController = BreedResultTableViewController()
        let resultsViewModel = BreedResultViewModel()
        resultsViewModel.$selectedBreed
            .assign(to: \.selectedBreed, on: self.viewModel)
            .store(in: &subscriptions)
        resultsViewModel.$isSearching
            .assign(to: \.isSearching, on: self.viewModel)
            .store(in: &subscriptions)
        resultController.viewModel = resultsViewModel
        let searchController = UISearchController(searchResultsController: resultController)
        searchController.extendedLayoutIncludesOpaqueBars = true
        searchController.searchResultsUpdater = resultController
        navigationItem.searchController = searchController
        self.searchController = searchController
    }
}

extension DogsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.breeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! BreedCollectionViewCell
        cell.setupViewModel(viewModel: viewModel.cellViewModel(for: indexPath.row))
        return cell
    }
}

extension DogsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension DogsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 2) - 12.0
        let height = width * 1.2
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 8, left: 8, bottom: 8, right: 8)
    }
}
