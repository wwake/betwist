import Foundation

typealias MatchEntry = UInt32
private let bytesPerMatchEntry = 3

extension Data {
  subscript(matchEntry matchEntry: Int) -> MatchEntry {
    let index = matchEntry * bytesPerMatchEntry

    return UInt32(self[index]) << 16
      | UInt32(self[index + 1]) << 8
      | UInt32(self[index + 2])
  }

  mutating func reserve(matchEntries: Int) {
    let zeros: [UInt8] = [0, 0, 0]

    for _ in 0..<matchEntries {
      append(contentsOf: zeros)
    }
  }

  mutating func overwriteBytes(matchEntry: Int, _ bytes: [UInt8]) {
    let byteOffset = matchEntry * bytesPerMatchEntry

    replaceSubrange(
      byteOffset..<(byteOffset + bytes.count),
      with: bytes
    )
  }

  func isEndMark(_ position: Int) -> Bool {
    self[position] == 0
  }
}
