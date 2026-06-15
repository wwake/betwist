import Foundation

struct TrieDataReader {
  let bytesPerMatchEntry = 4

  var data: Data

  subscript(row: Int) -> UInt32 {
    let base = row * bytesPerMatchEntry
    return UInt32(data[base]) << 24
      | UInt32(data[base + 1]) << 16
      | UInt32(data[base + 2]) << 8
      | UInt32(data[base + 3])
  }

  func isLastMatch(row: Int) -> Bool {
    (data[row * bytesPerMatchEntry] & 128) != 0
  }

  func character(row: Int) -> UInt8 {
    data[row * bytesPerMatchEntry] & 0x5f
  }

  func completesWord(row: Int) -> Bool {
    (data[row * bytesPerMatchEntry] & 0x20) != 0
  }

  func address(row: Int) -> Int {
    Int(self[row] & 0x00ff_ffff)
  }

  func canExtend(row: Int) -> Bool {
    address(row: row) != 0
  }
}
