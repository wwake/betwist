import Foundation

class DataBuilder {
  static let endMarker: [UInt8] = [0, 0xff, 0xff, 0xff]

  var data = Data()

  func make(trie: MakerTrie) -> Data {
    data = Data()

    data.append(contentsOf: Self.endMarker)

    _ = writeData(trie: trie)

    return data
  }

  func matchByte(match: MakerMatch) -> UInt8 {
    let isWordFlag = match.isWord ? UInt8(32) : 0
    let charValue = isWordFlag | match.char.asciiValue!
    return charValue
  }

  func asQuadbytes(_ charByte: UInt8, _ trieAddress: UInt32) -> [UInt8] {
    [
      charByte,
      UInt8((trieAddress >> 16) & 0xff),
      UInt8((trieAddress >> 8) & 0xff),
      UInt8(trieAddress & 0xff),
    ]
  }

  func writeData(trie: MakerTrie) -> UInt32 {
    if trie.next.isEmpty { return 0 }

    let startIndex = data.count

    data.reserve(quadbytes: trie.next.count + 1)

    for i in 0..<(trie.next.count) {
      let charByte = matchByte(match: trie.next[i])

      let childTrieAddress = writeData(trie: trie.next[i].trie)

      data.overwriteQuad(
        index: startIndex + i * 4,
        asQuadbytes(charByte, childTrieAddress)
      )
    }

    data.overwriteQuad(index: startIndex + 4 * trie.next.count, Self.endMarker)

    return UInt32(startIndex)
  }
}
