//
//  AllPokemonView.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/13/22.
//

import SwiftUI

struct AllPokemonView: View {
    
    @StateObject private var pokemonvm = AllPokemonViewModel()
    
    var body: some View {
        NavigationStack {
            List(pokemonvm.allPokemon, id: \.name) { pokemon in
                NavigationLink(destination: PokemonView()) {
                    HStack {
                        //Replace with async image of front defualt sprite
                        Image("pokeball")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(pokemon.name.capitalize)
                    }
                }
            }
        }
        .task {
            await pokemonvm.fetchAllPokemon()
        }
        .alert(isPresented: $pokemonvm.error.isPresent, error: pokemonvm.error) { }
    }
}

struct AllPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        AllPokemonView()
    }
}
