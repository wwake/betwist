import Foundation

typealias MatchEntry = UInt32

extension Data {
  subscript(matchEntry matchEntry: Int) -> MatchEntry {
    let index = 4 * matchEntry

    return UInt32(self[index]) << 24
      | UInt32(self[index + 1]) << 16
      | UInt32(self[index + 2]) << 8
      | UInt32(self[index + 3])
  }

  mutating func reserve(matchEntries: Int) {
    let zeros: [UInt8] = [0, 0, 0, 0]

    for _ in 0..<matchEntries {
      append(contentsOf: zeros)
    }
  }

  mutating func overwriteBytes(matchEntry: Int, _ bytes: [UInt8]) {
    let byteOffset = matchEntry * 4

    replaceSubrange(
      byteOffset..<(byteOffset + bytes.count),
      with: bytes
    )
  }

  func isEndMark(_ position: Int) -> Bool {
    self[position] == 0
  }
}
