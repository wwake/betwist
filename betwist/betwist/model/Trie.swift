import Foundation

struct Trie {
  let isWord: Bool
  let next: [(Character, Trie)]

  func contains(_ value: String) -> Bool {
    if value.isEmpty {
      return isWord
    }
    let first = value.first!
    let node = next.first(where: { $0.0 == first })
    return node?.1.contains(String(value.dropFirst())) ?? false
  }
}
