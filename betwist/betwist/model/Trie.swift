import Foundation

extension Character: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let s = try container.decode(String.self)
    // if it's not a single character, use code FFFF to indicate illegal value
    self = s.count == 1 ? s.first! : "\u{FFFF}"
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(String(describing: self))
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

struct Trie: Codable {
  let isWord: Bool
  let next: [TrieMatch]

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

class TrieNode {
  var isWord: Bool
  var next: [(Character, TrieNode)]

  init(isWord: Bool, next: [(Character, TrieNode)]) {
    self.isWord = isWord
    self.next = next
  }
}

class TrieBuilder {
  var root = TrieNode(isWord: false, next: [])

  func add(_ words: [String]) -> Self {
    for word in words {
      addWord(word)
    }
    return self
  }

  fileprivate func addWord(_ word: String) {
    let value = Array(word)

    var trie = root
    for letter in value {
      let node = trie.next.first(where: { $0.0 == letter })
      if node == nil {
        let newTrie = TrieNode(isWord: false, next: [])
        trie.next.append((letter, newTrie))
        trie = newTrie
      } else {
        trie = node!.1
      }
    }
    trie.isWord = true
  }

  func make() -> Trie {
    make(root)
  }

  func make(_ node: TrieNode) -> Trie {
    Trie(isWord: node.isWord, next: makeList(node.next))
  }

  fileprivate func makeList(_ list: [(Character, TrieNode)]) -> [TrieMatch] {
    list.map { ch, node in
      TrieMatch(ch, make(node))
    }
  }
}
