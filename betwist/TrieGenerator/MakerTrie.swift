public class MakerTrie {
  var next: [MakerMatch]

  public init(next: [MakerMatch]) {
    self.next = next
  }
}

public struct MakerMatch {
  let char: Character
  var isWord: Bool
  let trie: MakerTrie

  public init(_ char: Character, _ trie: MakerTrie) {
    self.char = char
    self.isWord = false
    self.trie = trie
  }
}
