import Foundation

struct Words: Decodable {
  let entries: [WordEntry]
}

struct WordEntry: Decodable, Equatable, Hashable {
  let word: String
//  let meanings: [Meaning]
}

struct Meaning: Decodable, Equatable, Hashable {
  let partOfSpeech: String
  let definitions: [Definition]
}

struct Definition: Decodable, Equatable, Hashable {
  let definition: String
}
