import Foundation

enum VocabularyLoader {
  static func loadStrings() -> [String] {
    let path = Bundle.main.path(forResource: "words", ofType: "list")!
    let words = try! String(contentsOfFile: path, encoding: .utf8)
      .split(separator: "\n")
      .map { String($0).uppercased() }
      .filter { $0.count >= Game.minimumSize }
    return words
  }
}
