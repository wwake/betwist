import Foundation

public struct Words: Decodable, Equatable, Hashable {
  let entries: [WordEntry]
}

public struct WordEntry: Decodable, Equatable, Hashable {
  public let word: String
  public let meanings: [Meaning]
}

public struct Meaning: Decodable, Equatable, Hashable {
  public let partOfSpeech: String
  public let definitions: [Definition]
}

public struct Definition: Decodable, Equatable, Hashable {
  public let definition: String
}
