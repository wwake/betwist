import Foundation

class BuilderTrie: Codable {
  var next: [BuilderMatch]

  init(next: [BuilderMatch]) {
    self.next = next
  }
}

struct BuilderMatch: Codable {
  let char: Character
  var isWord: Bool
  let trie: BuilderTrie

  init(_ char: Character, _ trie: BuilderTrie) {
    self.char = char
    self.isWord = false
    self.trie = trie
  }
}

class TrieBuilder {
  var root = BuilderTrie(next: [])

  func add(_ words: [String]) -> Self {
    for word in words {
      addWord(word)
    }
    return self
  }

  fileprivate func addWord(_ word: String) {
    let value = Array(word)

    var trie = root
    var lastTrie: BuilderTrie?
    for letter in value {
      lastTrie = trie
      let node = trie.next.first(where: { $0.char == letter })
      if node == nil {
        let newTrie = BuilderTrie(next: [])
        trie.next.append(BuilderMatch(letter, newTrie))
        trie = newTrie
      } else {
        trie = node!.trie
      }
    }
    let lastLetterIndex = lastTrie!.next.firstIndex { $0.char == value.last! }
    lastTrie!.next[lastLetterIndex!].isWord = true
  }

  func make() -> Trie {
    make(root)
  }

  fileprivate func make(_ node: BuilderTrie) -> Trie {
    Trie(makeList(node.next))
  }

  fileprivate func makeList(_ list: [BuilderMatch]) -> [TrieMatch] {
    list.map { match in
      TrieMatch(match.char, match.isWord, make(match.trie))
    }
  }

}

extension Data {
  subscript(quadbyte quadbyte: Int) -> UInt32 {
    let index = 4 * quadbyte

    return UInt32(self[index]) << 24
      | UInt32(self[index + 1]) << 16
      | UInt32(self[index + 2]) << 8
      | UInt32(self[index + 3])
  }
}
