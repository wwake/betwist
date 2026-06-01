import Foundation

extension Data {
  mutating func reserve(quadbytes: Int) {
    let zeros: [UInt8] = [0, 0, 0, 0]

    for _ in 0..<quadbytes {
      append(contentsOf: zeros)
    }
  }
}

extension Data {
  mutating func overwriteQuad(index: Int, _ bytes: [UInt8]) {
    replaceSubrange(
      index..<(index + 4),
      with: bytes
    )
  }
}
