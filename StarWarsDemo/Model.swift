//
//  Model.swift
//  StarWarsDemo
//
//  Created by Angelo Zambrano on 20/11/24.
//

import SwiftUI

public struct StarWarCharacterDTO: Codable {
    let id: Int
    let nombre: String
    let raza: String
    let descripcion: String
    let planetaOrigen: String
    let epoca: String
    let afiliacion: String
    let habilidades: String
    let armas: String
    let imagen: String
}

extension StarWarCharacterDTO {
    var toCard: StarWarCharacter {
        StarWarCharacter(
            id: id,
            name: nombre,
            race: raza,
            description: descripcion,
            homePlanet: planetaOrigen,
            era: epoca,
            affiliation: afiliacion.components(separatedBy: ", ").map(\.capitalized),
            abilities: habilidades.components(separatedBy: ", ").map(\.capitalized),
            weapons: armas.components(separatedBy: ", ").map(\.capitalized),
            image: imagen
        )
    }
}

public struct StarWarCharacter: Identifiable, Hashable {
    public let id: Int
    let name: String
    let race: String
    let description: String
    let homePlanet: String
    let era: String
    let affiliation: [String]
    let abilities: [String]
    let weapons: [String]
    let image: String
}
