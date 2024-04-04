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


enum BlockState {
    case normal
    case unable
    case correct
    case incorrect
    
    var image: BlockImage {
        switch self {
        case .normal: return .quizBlock
        case .unable: return .quizUnableBlock
        case .correct: return .quizCorrectBlock
        case .incorrect: return .quizIncorrectBlock
        }
    }
    
    var numberImage: NumberImage {
        switch self {
        case .normal: return .gray
        case .unable: return .lightGray
        case .correct: return .white
        case .incorrect: return .white
        }
    }
}

enum BlockImage: String {
    case quizBlock
    case quizUnableBlock
    case quizCorrectBlock
    case quizIncorrectBlock
}

enum NumberImage: String {
    case gray
    case lightGray
    case white
}
