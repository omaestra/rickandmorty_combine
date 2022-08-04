//
//  CharacterRepository.swift
//  RickAndMorty-Combine
//
//  Created by omaestra on 16/6/21.
//

import Foundation
import Combine

protocol CharacterRepositoryProtocol {
    func fetchCharacters() -> AnyPublisher<[Character], Error>
    func searchCharacter(with query: String) -> AnyPublisher<[Character], Error>
}

final class CharacterRepository {
    private let apiService: CharacterApiServiceProtocol
    
    init(service: CharacterApiServiceProtocol = CharacterApiService()) {
        self.apiService = service
    }
}

extension CharacterRepository: CharacterRepositoryProtocol {
    func fetchCharacters() -> AnyPublisher<[Character], Error> {
        return apiService.fetchCharacters()
    }
    
    func searchCharacter(with query: String) -> AnyPublisher<[Character], Error> {
        return apiService.searchCharacter(with: query)
    }
}
