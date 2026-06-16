import Foundation

public class DataBuilder {
  static var nodeCount = 0
  static var largestJump = 0

  let bytesPerMatchEntry = 4

  var data = Data()

  public init() { }

  public func write(_ url: URL) throws {
    let compressedData = try (data as NSData).compressed(using: .lzfse)
    try compressedData.write(to: url, options: [.atomic, .completeFileProtection])
  }

  public func make(trie: MakerTrie) -> Data {
    data = Data()

    writeData(trie: trie)

    print("Node count \(Self.nodeCount)")
    print("Largest jump \(Self.largestJump)")
    print("Data size \(data.count)")
    return data
  }

  func writeData(trie: MakerTrie) {
    writeFirstLetters(trie: trie)
  }

  func writeFirstLetters(trie: MakerTrie) {
    let startIndex = 0

    data.reserve(matchEntries: trie.next.count)

    for i in 0..<(trie.next.count) {
      let charByte = firstByte(
        match: trie.next[i],
        isLast: i == trie.next.count - 1
      )

      let childTrieRow = writeSubTrie(
        base: (UInt32) (data.count / bytesPerMatchEntry),
        trie: trie.next[i].trie
      )

      data.overwriteBytes(
        matchEntry: startIndex + i,
        asBytes(charByte, childTrieRow)
      )
      Self.largestJump = max(Self.largestJump, Int(childTrieRow) - startIndex + i)
    }
    Self.nodeCount += trie.next.count
  }

  func writeSubTrie(base: UInt32, trie: MakerTrie) -> UInt32 {
    if trie.next.isEmpty { return 0 }

    let startIndex = data.count / 4

    data.reserve(matchEntries: trie.next.count)

    for i in 0..<(trie.next.count) {
      let charByte = firstByte(
        match: trie.next[i],
        isLast: i == trie.next.count - 1
      )

      let nextRow = writeSubTrie(base: base, trie: trie.next[i].trie)
      let childTrieAddress = nextRow == 0 ? 0 : nextRow - base

      data.overwriteBytes(
        matchEntry: startIndex + i,
        asBytes(charByte, childTrieAddress)
      )
      Self.largestJump = max(Self.largestJump, Int(childTrieAddress) - startIndex + i)
    }
    Self.nodeCount += trie.next.count

    return UInt32(startIndex)
  }

  func firstByte(match: MakerMatch, isLast: Bool) -> UInt8 {
    let isLastFlag = isLast ? UInt8(128) : 0
    let isWordFlag = match.isWord ? UInt8(32) : 0
    let charValue = isLastFlag | isWordFlag | match.char.asciiValue!
    return charValue
  }

  func asBytes(_ charByte: UInt8, _ trieAddress: UInt32) -> [UInt8] {
    [
      charByte,
      UInt8((trieAddress >> 16) & 0xff),
      UInt8((trieAddress >> 8) & 0xff),
      UInt8(trieAddress & 0xff),
    ]
  }
}
