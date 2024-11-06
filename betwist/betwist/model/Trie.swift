import Foundation

struct Trie: Codable {
  let isWord: Bool
  let next: [TrieMatch]

  init(_ isWord: Bool, _ next: [TrieMatch]) {
    self.isWord = isWord
    self.next = next
  }

  func containsAndPrefixes(_ value: String) -> SearchResult {
    let target = Array(value)

    var trie = self
    for ch in target {
      let node = trie.next.first(where: { $0.char == ch })
      if node == nil { return SearchResult(isWord: false, isProperPrefix: false) }
      trie = node!.trie
    }
    return SearchResult(isWord: trie.isWord, isProperPrefix: !trie.next.isEmpty)
  }
}

struct TrieMatch: Codable {
  let char: Character
  let trie: Trie

  init(_ char: Character, _ trie: Trie) {
    self.char = char
    self.trie = trie
  }
}
