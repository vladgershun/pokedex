//
//  PokemonDetailModel.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/15/22.
//

import Foundation

struct PokemonDetails: Codable {
    let game_indices: [GameIndex]
    let height: Int
    let id: Int
    let moves: [Move]
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int
}

struct Info: Codable, Hashable {
    let name: String
    let url: String
}

struct GameIndex: Codable {
    let version: Info
}

struct Move: Codable {
    let move: Info
}

class Sprites: Codable {
    let back_default: String
    let back_shiny: String
    let front_default: String
    let front_shiny: String
}

struct TypeElement: Codable {
    let slot: Int
    let type: Info
}
