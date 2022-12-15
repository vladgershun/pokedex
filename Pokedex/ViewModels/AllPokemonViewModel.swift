//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/15/22.
//

import Foundation


final class AllPokemonViewModel: ObservableObject {
    
    @Published var pokemon = [Pokemon]()
    
    @MainActor
    func fetchAllPokemon() async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=2000") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(AllPokemon.self, from: data)
            pokemon = decodedResponse.results
        } catch {
            print("Invalid data")
        }
    }

}


