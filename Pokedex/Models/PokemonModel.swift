//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/13/22.
//

import Foundation

struct AllPokemon: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: String
}


