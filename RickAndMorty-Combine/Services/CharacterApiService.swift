//
//  CharacterApiService.swift
//  RickAndMorty-Combine
//
//  Created by omaestra on 16/6/21.
//

import Foundation
import Combine

enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}

protocol CharacterApiServiceProtocol {
    func fetchCharacters() -> AnyPublisher<[Character], Error>
    func searchCharacter(with query: String) -> AnyPublisher<[Character], Error>
}

final class CharacterApiService: CharacterApiServiceProtocol {
    func fetchCharacters() -> AnyPublisher<[Character], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        return Future<[Character], Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlRequest() else {
                promise(.failure(ServiceError.urlRequest))
                return
            }
            
            dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, _, error) in
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                do {
                    let characters = try JSONDecoder().decode(CharacterData.self, from: data)
                    promise(.success(characters.results))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            })
            
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func searchCharacter(with query: String) -> AnyPublisher<[Character], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        return Future<[Character], Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlRequest(with: query) else {
                promise(.failure(ServiceError.urlRequest))
                return
            }
            
            dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, _, error) in
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                do {
                    let characters = try JSONDecoder().decode(CharacterData.self, from: data)
                    promise(.success(characters.results))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            })
            
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlRequest(with query: String? = nil) -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        components.path = "/api/character"
        components.query = query
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        return urlRequest
    }
}
