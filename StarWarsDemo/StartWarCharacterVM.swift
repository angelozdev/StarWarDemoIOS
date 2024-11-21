//
//  StartWarCharacterVM.swift
//  StarWarsDemo
//
//  Created by Angelo Zambrano on 21/11/24.
//

import Foundation

enum LoadState {
    case idle
    case loading
    case success
    case failure(Error)
}

final class StartWarCharacterVM: ObservableObject {
    let repository: StarWarCharacterRepository
    @Published var characters: [StarWarCharacter] = []
    @Published var state: LoadState = .idle

    init(repository: StarWarCharacterRepository = StarWarCharacterRepository()) {
        self.repository = repository
    }

    func loadCharacters() async {
        state = .loading
        do {
            characters = try await repository.getCharacters()
            state = .success
        } catch {
            characters = []
            state = .failure(error)
            print("Hubo un error: \(error)")
        }
    }
}
