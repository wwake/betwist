struct Solver {
  let minimumAnswerSize: Int
  let vocabulary: Vocabulary
  let grid: LetterGrid
  let size: Int

  init(minimumAnswerSize: Int, vocabulary: Vocabulary, grid: LetterGrid) {
    self.minimumAnswerSize = minimumAnswerSize
    self.vocabulary = vocabulary
    self.grid = grid
    self.size = grid.size
  }

  func answers() -> Answers {
    var result = Answers()
    allAnswers
      .filter { $0.count >= minimumAnswerSize }
      .forEach {
        result.submit($0, isPrefix: true)
      }
    return result
  }

  fileprivate var allAnswers: Set<String> {
    var result = Set<String>()
    let selection = Selection(grid)
    tryAllExtensions(&result, selection)
    return result
  }

  fileprivate func tryAllExtensions(_ result: inout Set<String>, _ selection: Selection) {
    let neighbors = availableNeighbors(selection)

    for location in neighbors {
      let newSelection = Selection(selection, location)
      let searchResult = vocabulary.containsAndPrefixes(newSelection.answer)
      if searchResult.isWord {
        result.insert(newSelection.answer)
      }
      if searchResult.isProperPrefix {
        tryAllExtensions(&result, newSelection)
      }
    }
  }

  func availableNeighbors(_ selection: Selection) -> Set<Location> {
    guard selection.last != nil else {
      return allLocations
    }

    let locations = selection.last!.allNeighbors(wrap: size)

    return locations
      .filter {
        type(at: $0, in: selection) == .neighbor
      }
  }

  fileprivate var allLocations: Set<Location> {
    var neighbors = Set<Location>()
    for row in 0..<size {
      for column in 0..<size {
        neighbors.insert(Location(row, column))
      }
    }
    return neighbors
  }

  func type(at location: Location, in selection: Selection) -> SelectionType {
    selection.type(location)
  }
}
