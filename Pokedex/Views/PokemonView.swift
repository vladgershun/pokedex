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
        VStack {
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
            await pokemonDetailVM.getDetails()
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
