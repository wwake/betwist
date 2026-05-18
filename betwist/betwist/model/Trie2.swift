import Foundation

struct Trie2 {
  let data: TrieData
  let root = 4

  func containsAndPrefixes(_ target: String) -> SearchResult {
    walk(root, target)
  }

  private func walk(_ position: Int, _ target: String) -> SearchResult {
    if data.isEndMark(at: position) {
      return SearchResult(isWord: false, isProperPrefix: false)
    }
    if data.character(at: position) == target.first!.asciiValue! {
      return SearchResult(
        isWord: data.completesWord(at: position),
        isProperPrefix: false
      )
    }
    return SearchResult(isWord: true, isProperPrefix: true)
  }
}
