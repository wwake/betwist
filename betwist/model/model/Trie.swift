import Foundation

public struct Trie {
  let data: TrieDataReader
  let root = 0

  func containsAndPrefixes(_ target: String) -> SearchResult {
    if target.count == 1 {
      return SearchResult(isWord: false, isProperPrefix: true)
    }

    let base = data.jumpAddress(target.first!)
    var rest = target
    rest.removeFirst()

    return walk(base: base, target: rest)
  }

  private func walk(
    base: Int,
    target searchString: String
  ) -> SearchResult {
    var current = base
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

        current = base + data.address(row: current)
        continue
      }

      outOfOptions = data.isLastMatch(row: current)
      current += 1
    }

    return SearchResult(isWord: false, isProperPrefix: false)
  }
}
