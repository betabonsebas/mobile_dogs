//
//  BreedResultViewModel.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 1/06/23.
//

import Combine
import Foundation

class BreedResultViewModel: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []
    let provider: Provider
    @Published var breeds: [String] = []
    @Published var searchText: String? = String()
    @Published var selectedBreed: String?
    @Published var isSearching: Bool?
    
    init(provider: Provider = NetworkProvider()) {
        self.provider = provider
        $searchText
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap{ $0 }
            .sink { _ in
                
            } receiveValue: { [weak self] value in
                if let filters = self?.breeds.filter({ breed in breed.contains(value) }) {
                    self?.breeds = filters
                }
            }
            .store(in: &subscriptions)
    }
    
    func fetchBreeds() {
        provider.fetch(api: BreedAPI.allBreeds)?
            .map({ (result: ListResponse) in
                Array(result.message.keys)
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                  break
                case .failure(let error):
                  print(error)
                }
            }, receiveValue: { [weak self] result in
                self?.breeds.append(contentsOf: result)
            })
            .store(in: &subscriptions)
    }
}
