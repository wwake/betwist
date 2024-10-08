class Vocabulary {
  let words: [String]

  init(_ words: [String]) {
    self.words = words
  }

  func contains(_ word: String) -> Bool {
    words.contains(word)
  }

  func hasPrefix(_ prefix: String) -> Bool {
    words.contains { $0.starts(with: prefix) && $0 != prefix }
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
