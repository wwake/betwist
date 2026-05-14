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
  static let endMarker: [UInt8] = [0, 0xff, 0xff, 0xff]

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

  func makeData() -> Data {
    var data = Data()

    data.append(contentsOf: Self.endMarker)

    _ = writeData(&data, trie: root)

    return data
  }

  func reserve(_ data: inout Data, count: Int) {
    let zeros: [UInt8] = [0, 0, 0, 0]

    for _ in 0..<count {
      data.append(contentsOf: zeros)
    }
  }

  func writeData(_ data: inout Data, trie: BuilderTrie) -> UInt32 {
    if trie.next.isEmpty { return 0 }

    let startIndex = data.count

    reserve(&data, count: trie.next.count + 1)

    for i in 0..<(trie.next.count) {
      let match = trie.next[i]
      let isWordFlag = match.isWord ? UInt8(32) : 0
      let charValue = match.char.asciiValue! | isWordFlag

      let childTrie = writeData(&data, trie: trie.next[i].trie)

      data.replaceSubrange(
        (startIndex + i * 4)..<(startIndex + (i + 1) * 4),
        with: [
          charValue,
          UInt8((childTrie >> 16) & 0xff),
          UInt8((childTrie >> 8) & 0xff),
          UInt8(childTrie & 0xff),
        ]
      )
    }

    let lastIndex = trie.next.count
    data.replaceSubrange(
      (startIndex + lastIndex * 4)..<(startIndex + (lastIndex + 1) * 4),
      with: Self.endMarker
    )

    return UInt32(startIndex)
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
