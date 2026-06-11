import Foundation

public enum WordLoader {
  public static func load(path: String, minimumSize: Int) -> [String] {
    do {
      let words = try String(contentsOfFile: path, encoding: .utf8)
        .split(separator: "\n")
        .map { String($0).uppercased() }
        .filter { $0.count >= minimumSize }
      return words
    } catch {
      print("WordLoader: Can't load words from \(path)")
      return []
    }
  }
}
