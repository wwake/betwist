import Foundation

struct TrieData {
  var data: Data

  mutating func append(bytes values: [UInt8]) {
    data.append(contentsOf: values)
  }

  mutating func append(_ letter: Character, _ isWord: Bool, _ offset: Int) {
    let flag = isWord ? UInt8(0x20) : 0

    let byte0 = UInt8(letter.asciiValue! | flag)
    let byte1 = UInt8((offset >> 16) & 0xff)
    let byte2 = UInt8((offset >> 8) & 0xff)
    let byte3 = UInt8(offset & 0xff)

    append(bytes: [byte0, byte1, byte2, byte3])
  }

  subscript(byte byteOffset: Int) -> UInt8 {
    data[byteOffset]
  }

  subscript(quadbyte index: Int) -> UInt32 {
    UInt32(data[index]) << 24
      | UInt32(data[index + 1]) << 16
      | UInt32(data[index + 2]) << 8
      | UInt32(data[index + 3])
  }

  mutating func reserve(quadbytes: Int) {
    let zeros: [UInt8] = [0, 0, 0, 0]

    for _ in 0..<quadbytes {
      data.append(contentsOf: zeros)
    }
  }

  mutating func overwrite(at index: Int, bytes: [UInt8]) {
    data.replaceSubrange(
      index..<(index + bytes.count),
      with: bytes
    )
  }

  func isEndMark(at position: Int) -> Bool {
    data[position] == 0
  }

  func character(at position: Int) -> UInt8 {
    data[position] & 0x5f
  }

  func completesWord(at position: Int) -> Bool {
    (data[position] & 0x20) != 0
  }

  func address(at position: Int) -> Int {
    Int(self[quadbyte: position] & 0x00ff_ffff)
  }

  func canExtend(at position: Int) -> Bool {
    address(at: position) != 0
  }
}
