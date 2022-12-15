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

enum ErrorType: LocalizedError {
    case badConnection
    case notDecodable
    var errorDescription: String? {
        switch self {
        case .badConnection:
            return "Bad Connection"
        case .notDecodable:
            return "Bad Data"
        }
    }
}

extension Optional {
    var isPresent: Bool {
        get { self != nil }
        set {
            precondition(newValue == false)
            self = nil
        }
    }
}

extension String {
    var capitalize: String {
        let firstCharacter = self.prefix(1).capitalized
        let remainingCharacters = self.dropFirst().lowercased()
        return firstCharacter + remainingCharacters
    }
}
