class TrieNode: Codable {
  var isWord: Bool
  var next: [TrieNodeMatch]

  init(isWord: Bool, next: [TrieNodeMatch]) {
    self.isWord = isWord
    self.next = next
  }
}

struct TrieNodeMatch: Codable {
  let char: Character
  let trie: TrieNode

  init(_ char: Character, _ trie: TrieNode) {
    self.char = char
    self.trie = trie
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

  fileprivate func make(_ node: TrieNode) -> Trie {
    Trie(node.isWord, makeList(node.next))
  }

  fileprivate func makeList(_ list: [TrieNodeMatch]) -> [TrieMatch] {
    list.map { match in
      TrieMatch(match.char, make(match.trie))
    }
  }
}
