struct Game {
  static let minimumSize = 4
  static let maxPuzzleSize = 10

  var grid: LetterGrid
  var twister: Twister

  var selection: Selection
  var answers = Answers()

  var vocabulary: Vocabulary

  var message = ""

  private var hues: [Double]

  init(_ size: Int, _ source: any Sequence<String>, _ vocabulary: Vocabulary = NullVocabulary()) {
    self.grid = LetterGrid(size, source)
    self.twister = Twister(size)

    self.selection = Selection(grid)
    self.vocabulary = vocabulary

    self.hues = (0..<(Self.maxPuzzleSize * Self.maxPuzzleSize)).map { _ in Double.random(in: 0..<1.0) }
  }

  var size: Int {
    grid.size
  }

  var answer: String {
    selection.answer
  }

  subscript(_ row: Int, _ column: Int) -> String {
    let newLocation = twister[Location(row, column)]
    return grid[newLocation.row, newLocation.column]
  }

  subscript(_ location: Location) -> String {
    let newLocation = twister[location]
    return grid[newLocation.row, newLocation.column]
  }

  mutating func blockSelection() {
    selection.blocked = true
  }

  mutating func select(_ location: Location) {
    selection.select(twister[location])
    message = ""
  }

  mutating func deselectAll() {
    selection.clear()
    message = ""
  }

  func type(at location: Location) -> SelectionType {
    type(at: location, in: selection)
  }

  func type(at location: Location, in selection: Selection) -> SelectionType {
    selection.type(twister[location])
  }

  func hue(at location: Location) -> Double {
    let newLocation = twister[location]
    return hues[newLocation.row * size + newLocation.column]
  }

  mutating func validate() {
    if answer.count == 0 { return }

    if answer.count < Self.minimumSize {
      message = "Word is too short"
    } else if !vocabulary.contains(answer) {
      message = "That's not a word!"
    }
  }

  mutating func collect() {
    guard message.isEmpty && !answer.isEmpty else { return }

    for length in Self.minimumSize..<answer.count {
      let prefix = String(answer.prefix(length))
      if vocabulary.contains(prefix) {
        answers.submitPrefix(prefix)
      }
    }
    if vocabulary.contains(answer) {
      answers.submit(answer)
    }
  }

  func lastLocationSelected(was location: Location) -> Bool {
    selection.last == twister[location]
  }

  var allAnswers: Set<String> {
    var result = Set<String>()
    let selection = Selection(grid)
    tryAllExtensions(&result, selection, openNeighbors(selection))
    return result
  }

  func openNeighbors(_ selection: Selection) -> Set<Location> {
    guard selection.last != nil else {
      return allLocations
    }

    let locations = selection.last!.allNeighbors(wrap: size)

    return Set(locations)
      .filter {
        type(at: $0, in: selection) == .open
        || type(at: $0, in: selection) == .neighbor
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

  fileprivate func tryAllExtensions(_ result: inout Set<String>, _ selection: Selection, _ neighbors: Set<Location>) {
    for location in neighbors {
      let newSelection = Selection(selection, location)
      let (contained, prefixed) = vocabulary.containsAndPrefixes(newSelection.answer)
      if contained {
        result.insert(newSelection.answer)
      }
      if prefixed {
        let neighbors = openNeighbors(newSelection)
        tryAllExtensions(&result, newSelection, neighbors)
      }
    }
  }

  var score: Score {
    Score(wordCount: answers.wordCount, letterCount: answers.letterCount, mostLetters: answers.mostLetters)
  }

  mutating func rotateLeft() {
    twister.rotateLeft()
  }

  mutating func rotateRight() {
    twister.rotateRight()
  }
}
