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
}
