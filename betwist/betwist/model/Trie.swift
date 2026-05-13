import Foundation

struct Trie: Codable {
  let next: [TrieMatch]

  init(_ next: [TrieMatch]) {
    self.next = next
  }

  func containsAndPrefixes(_ value: String) -> SearchResult {
    let target = Array(value)

    var trie = self
    var matchesWord = false
    for ch in target {
      let node = trie.next.first(where: { $0.char == ch })
      if node == nil { return SearchResult(isWord: false, isProperPrefix: false) }
      matchesWord = node!.isWord
      trie = node!.trie
    }
    return SearchResult(isWord: matchesWord, isProperPrefix: !trie.next.isEmpty)
  }
}

struct TrieMatch: Codable {
  let char: Character
  let isWord: Bool
  let trie: Trie

  init(_ char: Character, _ isWord: Bool, _ trie: Trie) {
    self.char = char
    self.isWord = isWord
    self.trie = trie
  }
}
