//
//  AllPokemonView.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/13/22.
//

import SwiftUI

struct AllPokemonView: View {
    
    @StateObject private var pokemonVM = AllPokemonViewModel()
    
    var body: some View {
        NavigationStack {
            List(pokemonVM.allPokemon, id: \.name) { pokemon in
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
