import Foundation

public struct SearchResult: Equatable {
  let isWord: Bool
  let isProperPrefix: Bool
}

public class Vocabulary {
  private let trie: Trie

  public init(_ trie: Trie) {
    self.trie = trie
  }

  func contains(_ word: String) -> Bool {
    containsAndPrefixes(word).isWord
  }

  func containsAndPrefixes(_ target: String) -> SearchResult {
    trie.containsAndPrefixes(target)
  }
}
