struct Trie {
  let isWord: Bool
  let next: [(Character, Trie)]

  init(_ words: [String]) {
    isWord = false
    next = []
  }
}
