import Foundation

struct Words: Decodable {
  let entries: [WordEntry]
}

struct WordEntry: Decodable {
  let meanings: [Meaning]
}

struct Meaning: Decodable {
  let partOfSpeech: String
  let definitions: [Definition]
}

struct Definition: Decodable {
  let definition: String
}
