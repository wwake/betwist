import Foundation

struct SearchResult: Equatable {
  let isWord: Bool
  let isProperPrefix: Bool
}

class Vocabulary {
  let trie2: Trie2

  init(_ trie2: Trie2) {
    self.trie2 = trie2
  }

  func contains(_ word: String) -> Bool {
    containsAndPrefixes(word).isWord
  }

  func containsAndPrefixes(_ target: String) -> SearchResult {
    trie2.containsAndPrefixes(target)
  }
}

class NullVocabulary: Vocabulary {
  init() {
    super.init(Trie2(data: TrieData(data: Data())))
  }

  override func contains(_ word: String) -> Bool {
    true
  }
}
