import Foundation

struct Trie: Codable {
  let i: Bool
  let n: [TrieMatch]

  init(_ isWord: Bool, _ next: [TrieMatch]) {
    self.i = isWord
    self.n = next
  }

  var isWord: Bool { i }
  var next: [TrieMatch] { n }

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
  let c: Character
  let t: Trie

  init(_ char: Character, _ trie: Trie) {
    self.c = char
    self.t = trie
  }

  var char: Character { c }
  var trie: Trie { t }
}

struct TrieNodeMatch: Codable {
  let char: Character
  let trie: TrieNode

  init(_ char: Character, _ trie: TrieNode) {
    self.char = char
    self.trie = trie
  }
}

class TrieNode: Codable {
  var isWord: Bool
  var next: [TrieNodeMatch]

  init(isWord: Bool, next: [TrieNodeMatch]) {
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
      let node = trie.next.first(where: { $0.char == letter })
      if node == nil {
        let newTrie = TrieNode(isWord: false, next: [])
        trie.next.append(TrieNodeMatch(letter, newTrie))
        trie = newTrie
      } else {
        trie = node!.trie
      }
    }
    trie.isWord = true
  }

  func make() -> Trie {
    make(root)
  }

  func make(_ node: TrieNode) -> Trie {
    Trie(node.isWord, makeList(node.next))
  }

  fileprivate func makeList(_ list: [TrieNodeMatch]) -> [TrieMatch] {
    list.map { match in
      TrieMatch(match.char, make(match.trie))
    }
  }
}
