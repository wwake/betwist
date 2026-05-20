import Foundation

extension Trie {
  static func read(_ filename: String) -> Trie {
    do {
      if let path = Bundle.main.path(forResource: filename, ofType: "dat") {
        let decompressed = try NSData(contentsOfFile: path).decompressed(using: .lzfse)
        return Trie(data: TrieData(data: decompressed as Data))
      }
    } catch {
      print(error)
    }
    return Trie(data: TrieData(data: Data()))
  }

  static func write(_ url: URL, _ data: Data) throws {
    let compressedData = try (data as NSData).compressed(using: .lzfse)
    try compressedData.write(to: url, options: [.atomic, .completeFileProtection])
  }
}
