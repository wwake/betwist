import Foundation

extension Trie {
  static func load(_ filename: String) -> Trie {
    do {
      if let path = Bundle.main.path(forResource: filename, ofType: "json") {
        let data = try String(contentsOfFile: path, encoding: .utf8).data(using: .utf8)
        return try JSONDecoder().decode(Trie.self, from: data!)
      }
    } catch {
      print(error)
    }
    return Trie(false, [])
  }
}
