struct Vocabulary {
  let words: [String]

  init(_ words: [String]) {
    self.words = words
  }

  func contains(_ word: String) -> Bool {
    words.contains(word)
  }
}
