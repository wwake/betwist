class Vocabulary {
  let words: [String]

  init(_ words: [String]) {
    self.words = words
  }

  func contains(_ word: String) -> Bool {
    words.contains(word)
  }
}

class NullVocabulary: Vocabulary {
  init() {
    super.init([])
  }

  override func contains(_ word: String) -> Bool {
    true
  }
}
