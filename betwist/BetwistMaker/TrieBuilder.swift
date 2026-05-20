import Foundation


class TrieBuilder {
  var root = MakerTrie(next: [])

  func add(_ words: [String]) -> Self {
    for word in words {
      addWord(word)
    }
    return self
  }

  fileprivate func addWord(_ word: String) {
    let value = Array(word)

    var trie = root
    var lastTrie: MakerTrie?
    for letter in value {
      lastTrie = trie
      let node = trie.next.first(where: { $0.char == letter })
      if node == nil {
        let newTrie = MakerTrie(next: [])
        trie.next.append(MakerMatch(letter, newTrie))
        trie = newTrie
      } else {
        trie = node!.trie
      }
    }
    let lastLetterIndex = lastTrie!.next.firstIndex { $0.char == value.last! }
    lastTrie!.next[lastLetterIndex!].isWord = true
  }
}
