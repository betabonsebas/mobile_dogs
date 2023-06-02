//
//  BreedResultTableViewController.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 1/06/23.
//

import Combine
import UIKit

class BreedResultTableViewController: UITableViewController {
    
    private struct Constants {
        static let cellIdentifier = "resultCell"
    }
    
    private var subscriptions: Set<AnyCancellable> = []
    var viewModel: BreedResultViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        viewModel.$breeds
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                  break
                case .failure(let error):
                  print(error)
                }
            } receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.isSearching = true
        viewModel.fetchBreeds()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.breeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.breeds[indexPath.row]

        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breed = viewModel.breeds[indexPath.row]
        viewModel.selectedBreed = breed
        viewModel.isSearching = false
    }
}

extension BreedResultTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchText = searchController.searchBar.text?.lowercased()
    }
}
