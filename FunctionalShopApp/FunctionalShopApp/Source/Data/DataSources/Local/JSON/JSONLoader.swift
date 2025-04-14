//
//  JSONLoader.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 14.04.25.
//

import Foundation

protocol LocalJSONLoader {
    static func load<T: Decodable>(_ fileName: String, as type: T.Type) -> T
}

final class JSONLoader: LocalJSONLoader {
    static func load<T>(_ fileName: String, as type: T.Type) -> T where T : Decodable {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("❌ Failed to locate \(fileName).json in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("❌ Failed to load \(fileName).json from bundle.")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("❌ Failed to decode \(fileName).json: \(error)")
        }
    }
}
