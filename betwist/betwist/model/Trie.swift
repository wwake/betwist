import Foundation

struct Trie {
  let isWord: Bool
  let next: [(Character, Trie)]

  func contains(_ value: String) -> Bool {
    let stringAsArray = Array(value)
    return contains(stringAsArray, 0)
  }

  func contains(_ value: [Character], _ index: Int) -> Bool {
    if index == value.count {
      return isWord
    }
    let first = value[index]
    let node = next.first(where: { $0.0 == first })
    return node?.1.contains(value, index + 1) ?? false
  }
}
