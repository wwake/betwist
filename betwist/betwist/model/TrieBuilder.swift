import Foundation

class TrieBuilderNode: Codable {
  var isWord: Bool
  var next: [TrieBuilderNodeMatch]

  init(isWord: Bool, next: [TrieBuilderNodeMatch]) {
    self.isWord = isWord
    self.next = next
  }
}

struct TrieBuilderNodeMatch: Codable {
  let char: Character
  let isWord: Bool
  let trie: TrieBuilderNode

  init(_ char: Character, _ trie: TrieBuilderNode) {
    self.char = char
    self.isWord = false
    self.trie = trie
  }
}

class TrieBuilder {
  let emptyWord: [UInt8] = [0, 0, 0, 0]

  var root = TrieBuilderNode(isWord: false, next: [])

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
        let newTrie = TrieBuilderNode(isWord: false, next: [])
        trie.next.append(TrieBuilderNodeMatch(letter, newTrie))
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

  fileprivate func make(_ node: TrieBuilderNode) -> Trie {
    Trie(node.isWord, makeList(node.next))
  }

  fileprivate func makeList(_ list: [TrieBuilderNodeMatch]) -> [TrieMatch] {
    list.map { match in
      TrieMatch(match.char, make(match.trie))
    }
  }

  func makeData() -> Data {
    var data = Data()

    if !root.isWord && root.next.isEmpty {
      data.append(contentsOf: emptyWord)  // isWord flag
      data.append(contentsOf: emptyWord)  // last entry
    }
    return data
  }
}

extension Data {
  subscript(quadbyte quadbyte: Int) -> UInt32 {
    let index = 4 * quadbyte

    return UInt32(self[index]) << 24
      & UInt32(self[index + 1]) << 16
      & UInt32(self[index + 2]) << 8
      & UInt32(self[index + 3])
  }
}
