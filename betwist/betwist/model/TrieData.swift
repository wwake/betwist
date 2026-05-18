import Foundation

struct TrieData {
  var data: Data

  mutating func append(bytes values: [UInt8]) {
    data.append(contentsOf: values)
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
}
