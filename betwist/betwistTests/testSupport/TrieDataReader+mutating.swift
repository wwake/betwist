@testable import betwist

extension TrieDataReader {
  mutating func append(bytes values: [UInt8]) {
    data.append(contentsOf: values)
  }

  mutating func append(_ letter: Character, isWord: Bool, isLast: Bool, _ offset: Int) {
    let isLastFlag = isLast ? UInt8(128) : 0
    let isWordFlag = isWord ? UInt8(0x20) : 0

    let byte0 = UInt8(isLastFlag | isWordFlag | letter.asciiValue!)
    let byte1 = UInt8((offset >> 16) & 0xff)
    let byte2 = UInt8((offset >> 8) & 0xff)
    let byte3 = UInt8(offset & 0xff)

    append(bytes: [byte0, byte1, byte2, byte3])
  }

  mutating func reserve(matchEntries: Int) {
    let zeros: [UInt8] = [0, 0, 0, 0]

    for _ in 0..<matchEntries {
      data.append(contentsOf: zeros)
    }
  }

  mutating func overwrite(at index: Int, bytes: [UInt8]) {
    data.replaceSubrange(
      index..<(index + bytes.count),
      with: bytes
    )
  }
}
