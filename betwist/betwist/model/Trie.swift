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
      if data.character(row: current) == target.first!.asciiValue! {
        target.removeFirst()

        if target.isEmpty {
          return SearchResult(
            isWord: data.completesWord(row: current),
            isProperPrefix: data.canExtend(row: current)
          )
        }

        current = data.address(row: current)
        continue
      }

      outOfOptions = data.isLastMatch(row: current)
      current += 1
    }

    return SearchResult(isWord: false, isProperPrefix: false)
  }
}
