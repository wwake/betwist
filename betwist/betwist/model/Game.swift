enum GameMode {
  case play
  case review
}

struct Game {
  static let minimumSize = 4
  static let minimumSystemAnswerSize = 6
  static let maxPuzzleSize = 25

  var mode = GameMode.play

  let grid: LetterGrid
  var twister: Twister

  var selection: Selection

  var answers = Answers()

  var vocabulary: Vocabulary

  var message = ""

  private var hues: [Double]

  init(_ size: Int, _ source: any Sequence<String>, _ vocabulary: Vocabulary = NullVocabulary()) {
    self.grid = LetterGrid(size, Array(source))
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

  var hasAnswers: Bool {
    !answers.isEmpty
  }

  subscript(_ row: Int, _ column: Int) -> String {
    let newLocation = twister[Location(row, column)]
    return grid[newLocation.row, newLocation.column]
  }

  subscript(_ location: Location) -> String {
    let newLocation = twister[location]
    return grid[newLocation.row, newLocation.column]
  }

  mutating func select(_ location: Location) {
    selection.select(twister[location])
    message = ""
  }

  var hasSelection: Bool {
    !selection.isEmpty
  }

  mutating func deselectAll() {
    selection.clear()
    message = ""
  }

  func type(at location: Location) -> SelectionType {
    selection.type(twister[location])
  }

  func type(at location: Location, in selection: Selection) -> SelectionType {
    selection.type(location)
  }

  func hue(at location: Location) -> Double {
    let newLocation = twister[location]
    return hues[newLocation.row * size + newLocation.column]
  }

  mutating func validate() {
    if answer.count == 0 { return }

    if answer.count < Self.minimumSize {
      message = "Word is too short"
    } else if answers.contains(answer) {
      message = "Duplicate word!"
    } else if !vocabulary.contains(answer) {
      message = "That's not a word!"
    } else {
      message = ""
    }
  }

  var hasValidSelection: Bool {
    message.isEmpty
  }

  fileprivate func properPrefixes(of word: String) -> [String] {
    (Self.minimumSize..<word.count)
      .map { String(word.prefix($0)) }
  }

  mutating func submit(_ word: String) {
    for prefix in properPrefixes(of: word) where vocabulary.contains(prefix) {
        answers.submit(prefix, isPrefix: true)
    }

    if vocabulary.contains(word) {
      answers.submit(word, isPrefix: false)
    }

    deselectAll()
  }

  func lastLocationSelected(was location: Location) -> Bool {
    selection.last == twister[location]
  }

  var systemAnswers: Answers {
    Solver(
      minimumAnswerSize: Self.minimumSystemAnswerSize,
      vocabulary: vocabulary,
      grid: grid
    ).answers()
  }

  var score: Score {
    Score(wordCount: answers.wordCount, letterCount: answers.letterCount, mostLetters: answers.mostLetters)
  }

  mutating func rotate(clockwise: Bool) {
    if clockwise {
      twister.rotateRight()
    } else {
      twister.transform(Location.rotateLeft)
    }
  }
}
