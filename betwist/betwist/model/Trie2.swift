import Foundation

struct Trie2 {
  let data: Data
  let root = 4

  func containsAndPrefixes(_ value: String) -> SearchResult {
    walk(root)
  }

  private func walk(_ position: Int) -> SearchResult {
    if data.isEndMark(position) {
      return SearchResult(isWord: false, isProperPrefix: false)
    }
    return SearchResult(isWord: true, isProperPrefix: true)
  }
}
