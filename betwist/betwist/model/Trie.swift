import Foundation

struct Trie {
  let isWord: Bool
  let next: [(Character, Trie)]

  func containsAndPrefixes(_ value: String) -> SearchResult {
    let target = Array(value)

    var trie = self
    for ch in target {
      let node = trie.next.first(where: { $0.0 == ch })
      if node == nil { return SearchResult(isWord: false, isProperPrefix: false) }
      trie = node!.1
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

  fileprivate func makeList(_ list: [(Character, TrieNode)]) -> [(Character, Trie)] {
    list.map { ch, node in
      (ch, make(node))
    }
  }
}
