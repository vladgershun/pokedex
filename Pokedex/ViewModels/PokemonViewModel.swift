//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/15/22.
//

import Foundation

struct PokemonService {
    
    func fetchPokemonDetails(_ pokemonName: String) async throws -> PokemonDetails {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonName)") else {
            throw ErrorType.badConnection
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(PokemonDetails.self, from: data)
            return decodedResponse
        } catch {
            throw ErrorType.notDecodable
        }
        
    }
}

@MainActor
final class PokemonViewModel: ObservableObject {
    
    enum State {
        case notAvailable
        case loading
        case success(data: PokemonDetails)
        case failed(error: ErrorType)
    }
    
    @Published var pokemonName: String
    @Published private(set) var state: State = .notAvailable
    @Published var hasError: ErrorType?
    
    private let service: PokemonService
    
    init(service: PokemonService, pokemonName: String = "charizard") {
        self.service = service
        self.pokemonName = pokemonName
    }
    
    func fetchPokemonDetails() async {
        
        self.state = .loading
        self.hasError = nil

        do {
            let pokemonDetails = try await service.fetchPokemonDetails(pokemonName)
            self.state = .success(data: pokemonDetails)
        } catch {
            self.state = .failed(error: ErrorType.notDecodable)
            self.hasError = ErrorType.notDecodable
        }
    }
    
}

