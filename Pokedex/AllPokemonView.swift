//
//  ContentView.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/13/22.
//

import SwiftUI

struct AllPokemon: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct PokemonSprite: Codable {
    let name: String
    let url: String
}

struct AllPokemonView: View {
    @State var pokemon = [Pokemon]()
    
    var body: some View {
        NavigationStack {
            List(pokemon, id: \.name) { pokemon in
                Text(pokemon.name)
            }
        }
        .task {
            await fetchAllPokemon()
        }
    }
    
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
    
    func fetchAllSprites() async {
        for i in 1..<150 {
            
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(i)") else {
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
    
}

struct AllPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        AllPokemonView()
    }
}
