//
//  AllPokemonViewModel.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/15/22.
//

import Foundation

struct AllPokemonService {
    
    func fetchAllPokemon() async throws -> [Pokemon] {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=2000") else {
            throw ErrorType.badConnection
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(AllPokemon.self, from: data)
            return decodedResponse.results
        } catch {
            throw ErrorType.notDecodable
        }
        
    }
}

@MainActor
final class AllPokemonViewModel: ObservableObject {
    
    enum State {
        case notAvailable
        case loading
        case success(data: [Pokemon])
        case failed(error: ErrorType)
    }
    
    @Published private(set) var state: State = .notAvailable
    @Published var hasError: ErrorType?
    
    private let service: AllPokemonService
    
    init(service: AllPokemonService) {
        self.service = service
    }
    
    func fetchAllPokemon() async {
        
        self.state = .loading
        self.hasError = nil

        do {
            let allPokemon = try await service.fetchAllPokemon()
            self.state = .success(data: allPokemon)
        } catch {
            self.state = .failed(error: ErrorType.notDecodable)
            self.hasError = ErrorType.notDecodable
        }
    }

}




