import Foundation

class DataBuilder {
  static let endMarker: [UInt8] = [0, 0xff, 0xff, 0xff]

  var data = Data()

  func make(trie: BuilderTrie) -> Data {
    data = Data()

    data.append(contentsOf: Self.endMarker)

    _ = writeData(trie: trie)

    return data
  }

  func writeData(trie: BuilderTrie) -> UInt32 {
    if trie.next.isEmpty { return 0 }

    let startIndex = data.count

    data.reserve(quadbytes: trie.next.count + 1)

    for i in 0..<(trie.next.count) {
      let match = trie.next[i]
      let isWordFlag = match.isWord ? UInt8(32) : 0
      let charValue = match.char.asciiValue! | isWordFlag

      let childTrie = writeData(trie: trie.next[i].trie)

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
    let range = (startIndex + lastIndex * 4)..<(startIndex + (lastIndex + 1) * 4)
    data.replaceSubrange(
      range,
      with: Self.endMarker
    )

    return UInt32(startIndex)
  }
}
