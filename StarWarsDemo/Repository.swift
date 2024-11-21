//
//  Utils.swift
//  StarWarsDemo
//
//  Created by Angelo Zambrano on 21/11/24.
//

import Foundation

enum RepositoryError: Error, LocalizedError {
    case fileNotFound
    case dataCorrupted(underlyingError: Error)

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "The file could not be found in the app bundle."

        case let .dataCorrupted(error):
            return "The data could not be decoded. Reason: \(error.localizedDescription)"
        }
    }
}

protocol DataLoader {
    func loadData(fromFile fileName: String, withExtension fileExtension: String) throws -> Data
}

class BundleDataLoader: DataLoader {
    func loadData(fromFile fileName: String, withExtension fileExtension: String) throws -> Data {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        else { throw RepositoryError.fileNotFound }

        return try Data(contentsOf: url)
    }
}

class StarWarCharacterRepository {
    private let dataLoader: DataLoader

    init(dataLoader: DataLoader = BundleDataLoader()) {
        self.dataLoader = dataLoader
    }

    private func decodeCharacters(from data: Data) throws -> [StarWarCharacter] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dtos = try decoder.decode([StarWarCharacterDTO].self, from: data)
        return dtos.map(\.toCard)
    }

    func getCharacters() async throws -> [StarWarCharacter] {
        let data = try dataLoader.loadData(fromFile: "Characters", withExtension: "json")
        return try decodeCharacters(from: data)
    }
}
