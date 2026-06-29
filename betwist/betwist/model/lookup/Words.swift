import Foundation

struct Words: Codable {
  let entries: [WordEntry]
}

struct WordEntry: Codable {
  let meanings: [Meaning]
}

struct Meaning: Codable {
  let partOfSpeech: String
  let definitions: [Definition]
}

struct Definition: Codable {
  let definition: String
}
