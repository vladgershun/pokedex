//
//  PokemonDetailModel.swift
//  Pokedex
//
//  Created by Vlad Gershun on 12/15/22.
//

import Foundation

struct PokemonDetails: Codable {
        let abilities: [Ability]
        let gameIndices: [GameIndex]
        let height: Int
        let id: Int
        let locationAreaEncounters: String
        let moves: [Move]
        let name: String
        let sprites: Sprites
        let types: [TypeElement]
        let weight: Int
}

struct Info: Codable {
    let name: String
    let url: String
}

struct Ability: Codable {
    let ability: Info
}

struct GameIndex: Codable {
    let version: Info
}

struct Move: Codable {
    let move: Info
}

class Sprites: Codable {
    let backDefault: String
    let backShiny: String
    let frontDefault: String
    let frontShiny: String
}

struct TypeElement: Codable {
    let slot: Int
    let type: Info
}
