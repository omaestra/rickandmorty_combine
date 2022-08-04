//
//  CharacterViewModel.swift
//  RickAndMorty-Combine
//
//  Created by omaestra on 16/6/21.
//

import Foundation
import Combine

enum ListViewModelState {
    case loading
    case finished
    case error(Error)
}

final class CharacterViewModel: ObservableObject {
    private(set) var characters = CurrentValueSubject<[Character], Never>([])
    private(set) var searchText = CurrentValueSubject<String, Never>("")
    private(set) var state = CurrentValueSubject<ListViewModelState, Never>(.loading)
    
    private var bindings = Set<AnyCancellable>()
    
    private let repository: CharacterRepositoryProtocol
    
    init(repository: CharacterRepositoryProtocol = CharacterRepository()) {
        self.repository = repository
        setupSearch()
    }
    
    func setupSearch() {
        searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .map { [unowned self] (searchText) -> AnyPublisher<[Character], Never> in
                
                self.repository.searchCharacter(with: "name=\(searchText)")
                    .catch { (error) in
                        Just([Character]())
                    }
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .sink { [unowned self] (characters) in
                self.characters.send(characters)
            }.store(in: &bindings)
    }
    
    func fetchCharacters() {
        state.send(.loading)
        
        repository
            .fetchCharacters()
            .sink { [unowned self] (completion) in
                switch completion {
                case .failure(let error): self.state.send(.error(error))
                case .finished: self.state.send(.finished)
                }
            } receiveValue: { [unowned self] (characters) in
                self.characters.send(characters)
            }
            .store(in: &bindings)
    }
}
