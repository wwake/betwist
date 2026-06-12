import Foundation

struct Trie {
  let data: TrieDataReader
  let root = 0
  let bytesPerMatchEntry = 4

  func containsAndPrefixes(_ target: String) -> SearchResult {
    walk(root, target)
  }

  private func walk(_ matchRow: Int, _ searchString: String) -> SearchResult {
    var current = matchRow
    var target = searchString

    var outOfOptions = false

    while !outOfOptions {
      if data.character(at: current) == target.first!.asciiValue! {
        target.removeFirst()

        if target.isEmpty {
          return SearchResult(
            isWord: data.completesWord(at: current),
            isProperPrefix: data.canExtend(at: current)
          )
        }

        current = data.address(at: current)
        continue
      }

      outOfOptions = data.isLastMatch(at: current)
      current += 1
    }

    return SearchResult(isWord: false, isProperPrefix: false)
  }
}
