import Foundation

public struct Words: Decodable, Equatable, Hashable {
  let entries: [WordEntry]
}

public struct WordEntry: Decodable, Equatable, Hashable {
  let word: String
  let meanings: [Meaning]
}

public struct Meaning: Decodable, Equatable, Hashable {
  let partOfSpeech: String
  let definitions: [Definition]
}

public struct Definition: Decodable, Equatable, Hashable {
  let definition: String
}
