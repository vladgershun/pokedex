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
        ZStack {
            switch pokemonDetailVM.state {
            case .success(let pokemonDetails):
                List {

                    AsyncImage(url: URL(string: pokemonDetails.sprites.front_default), scale: 1) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 200)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Text("ID: \(pokemonDetails.id)")
                                .font(.headline)
                                .padding()
                            Text("Height: \(pokemonDetails.height)")
                                .font(.headline)
                                .padding()
                            Text("Weight: \(pokemonDetails.weight)")
                                .font(.headline)
                                .padding()
                        } 
                    }
                    
                    Section(header: Text("Types")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(pokemonDetails.types, id: \.type) { element in
                                    Image(element.type.name)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Text(element.type.name.uppercased())
                                        .font(.headline)
                                        .padding()
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Moves")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(pokemonDetails.moves, id: \.move) { move in
                                    Text(move.move.name.uppercased())
                                        .font(.headline)
                                        .padding()
                                }
                            }
                        }
                    }
                    
                    
                    Section(header: Text("Sprites")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                AsyncImage(url: URL(string: pokemonDetails.sprites.front_default), scale: 1) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 120, height: 120)
                                
                                AsyncImage(url: URL(string: pokemonDetails.sprites.front_shiny), scale: 1) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 120, height: 120)
                                
                                AsyncImage(url: URL(string: pokemonDetails.sprites.back_default), scale: 1) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 120, height: 120)
                                
                                AsyncImage(url: URL(string: pokemonDetails.sprites.back_shiny), scale: 1) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 120, height: 120)
                            }
                        }
                    }
                    
                    
 
                    
                    
      
                }
                .navigationTitle(pokemonDetails.name.uppercased())
                .navigationBarTitleDisplayMode(.inline)

                
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
