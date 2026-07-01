import Foundation

typealias MatchEntry = UInt32

public struct TrieDataReader {
  let bytesPerMatchEntry = 3

  var data: Data

  private func matchEntry(row: Int) -> MatchEntry {
    let base = row * bytesPerMatchEntry
    return UInt32(data[base]) << 16
      | UInt32(data[base + 1]) << 8
      | UInt32(data[base + 2])
  }

  private func matchEntryChar(row: Int) -> UInt8 {
    data[row * bytesPerMatchEntry]
  }

  public func jumpAddress(_ char: Character) -> Int {
    Int(matchEntry(row: Int(char.asciiValue! - Character("A").asciiValue!)))
  }

  public func isLastMatch(row: Int) -> Bool {
    (matchEntryChar(row: row) & 0x80) != 0
  }

  public func completesWord(row: Int) -> Bool {
    (matchEntryChar(row: row) & 0x20) != 0
  }

  public func character(row: Int) -> UInt8 {
    matchEntryChar(row: row) & 0x5f
  }

  public func address(row: Int) -> Int {
    Int(matchEntry(row: row) & 0xffff)
  }

  public func canExtend(row: Int) -> Bool {
    address(row: row) != 0
  }
}
