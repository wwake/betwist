import Foundation

struct Trie {
  let isWord: Bool
  let next: [(Character, Trie)]

  func containsAndPrefixes(_ value: String) -> SearchResult {
    let target = Array(value)

    var trie = self
    for ch in target {
      let node = next.first(where: { $0.0 == ch })
      if node == nil { return SearchResult(isWord: false, isProperPrefix: false) }
      trie = node!.1
    }
    return SearchResult(isWord: trie.isWord, isProperPrefix: !trie.next.isEmpty)
  }
}
