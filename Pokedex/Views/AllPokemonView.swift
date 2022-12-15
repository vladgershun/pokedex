//
//  ContentView.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/13/22.
//

import SwiftUI

struct AllPokemonView: View {
    @StateObject private var pokemonvm = AllPokemonViewModel()
    
    var body: some View {
        NavigationStack {
            List(pokemonvm.pokemon, id: \.name) { pokemon in
                Text(pokemon.name.uppercased())
            }
        }
        .task {
            await pokemonvm.fetchAllPokemon()
        }
    }
}

struct AllPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        AllPokemonView()
    }
}
