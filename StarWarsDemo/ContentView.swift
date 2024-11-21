//
//  ContentView.swift
//  StarWarsDemo
//
//  Created by Angelo Zambrano on 20/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm: StartWarCharacterVM = StartWarCharacterVM()

    var body: some View {
        NavigationStack {
            Group {
                switch vm.state {
                case .idle, .loading:
                    ProgressView("Loading characters...")
                case .success:
                    List(vm.characters, id: \.id) {
                        character in StarWarCharacterView(character: character)
                    }
                case let .failure(error):
                    VStack {
                        Text("Failed to load characters: \(error.localizedDescription)")
                            .foregroundColor(.red)
                        Button("Retry") {
                            Task {
                                await vm.loadCharacters()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Star War Characters")
        .task {
            await vm.loadCharacters()
        }
    }
}

#Preview {
    ContentView()
}
