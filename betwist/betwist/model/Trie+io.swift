import Foundation

extension Trie {
  static func read(_ filename: String) -> Trie {
    do {
      if let path = Bundle.main.path(forResource: filename, ofType: "json-compressed") {
        let decompressed = try NSData(contentsOfFile: path).decompressed(using: .lzfse)
        return try JSONDecoder().decode(Trie.self, from: decompressed as Data)
      }
    } catch {
      print(error)
    }
    return Trie(false, [])
  }

  func write(_ url: URL) throws {
    let data = try JSONEncoder().encode(self)
    let compressedData = try (data as NSData).compressed(using: .lzfse)
    try compressedData.write(to: url, options: [.atomic, .completeFileProtection])
  }
}
