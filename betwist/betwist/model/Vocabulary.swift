import Foundation

struct SearchResult: Equatable {
  let isWord: Bool
  let isProperPrefix: Bool
}

class Vocabulary {
  private let trie: Trie

  init(_ trie: Trie) {
    self.trie = trie
  }

  func contains(_ word: String) -> Bool {
    containsAndPrefixes(word).isWord
  }

  func containsAndPrefixes(_ target: String) -> SearchResult {
    trie.containsAndPrefixes(target)
  }
}

class NullVocabulary: Vocabulary {
  init() {
    super.init(Trie(data: TrieData(data: Data())))
  }

  override func contains(_ word: String) -> Bool {
    true
  }
}
