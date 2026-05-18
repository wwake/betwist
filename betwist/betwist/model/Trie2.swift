import Foundation

struct Trie2 {
  let data: TrieData
  let root = 4

  func containsAndPrefixes(_ target: String) -> SearchResult {
    walk(root, target)
  }

  private func walk(_ position: Int, _ target: String) -> SearchResult {
    if data.isEndMark(position) {
      return SearchResult(isWord: false, isProperPrefix: false)
    }
    if (data[position] & 0x5f) == target.first!.asciiValue! {
      return SearchResult(
        isWord: (data[position] & 0x20) != 0,
        isProperPrefix: false
      )
    }
    return SearchResult(isWord: true, isProperPrefix: true)
  }
}
