import Foundation

struct TrieDataReader {
  let bytesPerMatchEntry = 4

  var data: Data

  subscript(byte byteOffset: Int) -> UInt8 {
    data[byteOffset]
  }

  subscript(quadbyte index: Int) -> UInt32 {
    UInt32(data[index]) << 24
      | UInt32(data[index + 1]) << 16
      | UInt32(data[index + 2]) << 8
      | UInt32(data[index + 3])
  }

  func isLastMatch(at row: Int) -> Bool {
    (data[row * bytesPerMatchEntry] & 128) != 0
  }

  func character(at row: Int) -> UInt8 {
    data[row * bytesPerMatchEntry] & 0x5f
  }

  func completesWord(at row: Int) -> Bool {
    (data[row * bytesPerMatchEntry] & 0x20) != 0
  }

  func address(at row: Int) -> Int {
    Int(self[quadbyte: row * bytesPerMatchEntry] & 0x00ff_ffff) / bytesPerMatchEntry
  }

  func canExtend(at row: Int) -> Bool {
    address(at: row) != 0
  }
}
