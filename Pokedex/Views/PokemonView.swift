//
//  PokemonView.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/15/22.
//

import SwiftUI

struct PokemonView: View {
    
    @StateObject private var pokemonDetailVM = PokemonViewModel(service: PokemonService())
    
    var body: some View {
        ScrollView {
            switch pokemonDetailVM.state {
            case .success(let pokemonDetails):
                Text(pokemonDetails.name)
            case .loading:
                ProgressView()
            default:
                EmptyView()
            }
        }
        .task {
            await pokemonDetailVM.fetchPokemonDetails()
        }
        .alert(isPresented: $pokemonDetailVM.hasError.isPresent, error: pokemonDetailVM.hasError) {
            Button("Retry") {
                Task {
                    await pokemonDetailVM.fetchPokemonDetails()
                }
            }
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
