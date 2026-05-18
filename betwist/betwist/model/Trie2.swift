import Foundation

struct Trie2 {
  let data: TrieData
  let root = 4

  func containsAndPrefixes(_ target: String) -> SearchResult {
    walk(root, target)
  }

  private func walk(_ position: Int, _ target: String) -> SearchResult {
    var current = position

    while !data.isEndMark(at: current) {
      if data.character(at: current) == target.first!.asciiValue! {
        return SearchResult(
          isWord: data.completesWord(at: current),
          isProperPrefix: false
        )
      }

      current += 4
    }

    return SearchResult(isWord: false, isProperPrefix: false)
  }
}
