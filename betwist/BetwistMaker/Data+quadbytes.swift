import Foundation

public extension Data {
  subscript(quadbyte quadbyte: Int) -> UInt32 {
    let index = 4 * quadbyte

    return UInt32(self[index]) << 24
      | UInt32(self[index + 1]) << 16
      | UInt32(self[index + 2]) << 8
      | UInt32(self[index + 3])
  }
}

public extension Data {
  mutating func reserve(quadbytes: Int) {
    let zeros: [UInt8] = [0, 0, 0, 0]

    for _ in 0..<quadbytes {
      append(contentsOf: zeros)
    }
  }
}

public extension Data {
  mutating func overwriteQuad(index: Int, _ bytes: [UInt8]) {
    replaceSubrange(
      index..<(index + 4),
      with: bytes
    )
  }
}

public extension Data {
  func isEndMark(_ position: Int) -> Bool {
    self[position] == 0
  }
}
