//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/15/22.
//

import Foundation


final class AllPokemonViewModel: ObservableObject {
    
    @Published var pokemon = [Pokemon]()
    @Published var error: ErrorType?
    
    @MainActor
    func fetchAllPokemon() async {
        // Skipping this error 
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=2000") else {
            self.error = ErrorType.badConnection
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(AllPokemon.self, from: data)
            pokemon = decodedResponse.results
        } catch {
            self.error = ErrorType.notDecodable
        }
    }
}




