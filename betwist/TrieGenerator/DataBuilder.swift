import Foundation

public class DataBuilder {
  static var nodeCount = 0
  static var largestJump = 0

  var data = Data()

  public init() { }

  public func write(_ url: URL) throws {
    let compressedData = try (data as NSData).compressed(using: .lzfse)
    try compressedData.write(to: url, options: [.atomic, .completeFileProtection])
  }

  public func make(trie: MakerTrie) -> Data {
    data = Data()

    _ = writeData(trie: trie)

    print("Node count \(Self.nodeCount)")
    print("Largest jump \(Self.largestJump)")
    print("Data size \(data.count)")
    return data
  }

  func writeData(trie: MakerTrie) -> UInt32 {
    if trie.next.isEmpty { return 0 }

    let startIndex = data.count / 4

    data.reserve(matchEntries: trie.next.count)

    for i in 0..<(trie.next.count) {
      let charByte = firstByte(
        match: trie.next[i],
        isLast: i == trie.next.count - 1
      )

      let childTrieAddress = writeData(trie: trie.next[i].trie)

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
