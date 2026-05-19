import Foundation

struct SearchResult: Equatable {
  let isWord: Bool
  let isProperPrefix: Bool
}

class Vocabulary {
  let trie: Trie
  let trie2: Trie2

  init(_ trie: Trie, _ trie2: Trie2) {
    self.trie = trie
    self.trie2 = trie2
  }

  func contains(_ word: String) -> Bool {
    containsAndPrefixes(word).isWord
  }

  func containsAndPrefixes(_ target: String) -> SearchResult {
    let result = trie.containsAndPrefixes(target)
    let result2 = trie2.containsAndPrefixes(target)
    if result != result2 {
      print("Expected \(result) but got \(result2) for target \(target)")
    }
    return result
  }
}

class NullVocabulary: Vocabulary {
  init() {
    super.init(Trie([]), Trie2(data: TrieData(data: Data())))
  }

  override func contains(_ word: String) -> Bool {
    true
  }
}
