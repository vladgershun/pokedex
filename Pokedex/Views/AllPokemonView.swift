//
//  AllPokemonView.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/13/22.
//

import SwiftUI

struct AllPokemonView: View {
    
    @StateObject private var pokemonVM = AllPokemonViewModel(service: AllPokemonService())
    
    var body: some View {
        NavigationStack {
            switch pokemonVM.state {
            case .success(let allPokemon):
                List(allPokemon, id: \.name) { pokemon in
                    NavigationLink(destination: PokemonView()) {
                        HStack {
                            Image("pokeball")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(pokemon.name.capitalize)
                        }
                    }
                }
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .task {
            await pokemonVM.fetchAllPokemon()
        }
        .alert(isPresented: $pokemonVM.hasError.isPresent, error: pokemonVM.hasError) { }
    }
}

struct AllPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        AllPokemonView()
    }
}
