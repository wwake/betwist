import Foundation

typealias MatchEntry = UInt32

public struct TrieDataReader {
  let bytesPerMatchEntry = 4

  var data: Data

  private func matchEntry(row: Int) -> MatchEntry {
    let base = row * bytesPerMatchEntry
    return UInt32(data[base]) << 24
      | UInt32(data[base + 1]) << 16
      | UInt32(data[base + 2]) << 8
      | UInt32(data[base + 3])
  }

  private func matchEntryChar(row: Int) -> UInt8 {
    data[row * bytesPerMatchEntry]
  }

  public func isLastMatch(row: Int) -> Bool {
    (matchEntryChar(row: row) & 128) != 0
  }

  public func character(row: Int) -> UInt8 {
    matchEntryChar(row: row) & 0x5f
  }

  public func completesWord(row: Int) -> Bool {
    (matchEntryChar(row: row) & 0x20) != 0
  }

  public func address(row: Int) -> Int {
    Int(matchEntry(row: row) & 0x00ff_ffff)
  }

  public func canExtend(row: Int) -> Bool {
    address(row: row) != 0
  }
}
