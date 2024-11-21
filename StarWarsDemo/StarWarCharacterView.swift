//
//  StarWarCharacterView.swift
//  StarWarsDemo
//
//  Created by Angelo Zambrano on 21/11/24.
//

import SwiftUI

struct StarWarCharacterView: View {
    let character: StarWarCharacter

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(character.name).font(.headline)
                Text(character.race).foregroundStyle(.secondary)
                Text(character.affiliation.formatted(.list(type: .and))).font(.footnote)
            }
        }
    }
}

#Preview {
    StarWarCharacterView(character:
        StarWarCharacter(
            id: 1,
            name: "Angelo Zambrano",
            race: "Human",
            description: "Frontend Developer",
            homePlanet: "Earth",
            era: "2024",
            affiliation: ["Swift Developers", "OpenAI Enthusiasts", "Rust Developer"],
            abilities: ["Coding", "Problem-Solving", "UI/UX Design"],
            weapons: ["Keyboard", "Mouse", "Creativity"],
            image: "angelo"
        )
    )
}
