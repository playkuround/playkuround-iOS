//
//  Quiz.swift
//  playkuround-iOS
//
//  Created by Seoyeon Choi on 4/1/24.
//

import Foundation

struct Quiz: Codable {
    let question: String
    let options: [String]
    let answer: Int
}

func load<T: Decodable>(_ fileName: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil)
    else {
        fatalError("Couldn't find \(fileName) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    }
    catch {
        fatalError("Couldn't load \(fileName) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        
        return try decoder.decode(T.self, from: data)
    }
    catch {
        fatalError("Couldn't parse \(fileName) as \(T.self):\n\(error)")
    }
}
