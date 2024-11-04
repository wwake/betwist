import Foundation

struct Trie {
  let isWord: Bool
  let next: [(Character, Trie)]

  func contains(_ value: String) -> Bool {
    let target = Array(value)

    var trie = self
    for ch in target {
      let node = next.first(where: { $0.0 == ch })
      if node == nil { return false }
      trie = node!.1
    }
    return trie.isWord
  }
}
