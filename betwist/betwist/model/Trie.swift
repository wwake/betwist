import Foundation

struct Trie {
  let data: TrieDataReader
  let root = 4

  func containsAndPrefixes(_ target: String) -> SearchResult {
    walk(root, target)
  }

  private func walk(_ position: Int, _ searchString: String) -> SearchResult {
    var current = position
    var target = searchString

    var keepGoing = true

    while keepGoing {
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

      keepGoing = !data.isLastMatch(at: current)
      current += 4
    }

    return SearchResult(isWord: false, isProperPrefix: false)
  }
}
