//
//  DogsViewModel.swift
//  mobile_dogs
//
//  Created by Sebastian Bonilla on 1/06/23.
//

import Combine
import Foundation

class DogsViewModel: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []
    private var provider: Provider
    var title: String = "Dog breeds"
    @Published var breeds: [Breed] = []
    @Published var newBreed: Breed?
    @Published var selectedBreed: String?
    @Published var isSearching: Bool?
    
    init(provider: Provider = NetworkProvider()) {
        self.provider = provider
        $newBreed
            .sink { [weak self] value in
                if let breed = value {
                    self?.breeds.append(breed)
                }
            }
            .store(in: &subscriptions)
        $selectedBreed
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .sink {[weak self] value in
                if let breed = value {
                    self?.fetchImage(for: breed)
                }
            }
            .store(in: &subscriptions)
    }
    
    func fetchImage(for breed: String) {
        provider.fetch(api: BreedAPI.breed(breed))?
            .map({ (result: SingleResponse) in
                return Breed(name: breed, image: result.message)
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                  break
                case .failure(let error):
                  print(error)
                }
            }, receiveValue: { [weak self] value in
                self?.breeds.append(value)
            })
            .store(in: &subscriptions)
    }
    
    func cellViewModel(for index: Int) -> BreedViewModel {
        let breed = breeds[index]
        return BreedViewModel(breed: breed)
    }
}
