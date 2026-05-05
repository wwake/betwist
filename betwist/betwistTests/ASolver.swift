import Testing

@testable import betwist

struct ASolver {
  fileprivate func split(_ input: [String]) -> [String] {
    input
      .map { Array($0) }
      .flatMap { $0 }
      .map { String($0) }
  }

  fileprivate func matches(_ a1: Answers, _ a2: Answers) -> Bool {
    a1.allWords == a2.allWords
  }

  @Test
  func openNeighbors_includes_all_locations_when_selection_empty() {
    let game = Game(2, ["F", "U", "N", "D"])
    let sut = Solver(minimumAnswerSize: 4, vocabulary: game.vocabulary, grid: game.grid)
    let selection = Selection(game.grid)

    #expect(sut.availableNeighbors(selection) == [Location(0, 0), Location(0, 1), Location(1, 0), Location(1, 1)])
  }

  @Test
  func knows_openNeighbors() {
    let game = Game(2, ["F", "U", "N", "D"])
    let sut = Solver(minimumAnswerSize: 4, vocabulary: game.vocabulary, grid: game.grid)
    var selection = Selection(game.grid)
    selection.select(Location(0, 0))

    #expect(sut.availableNeighbors(selection) == [Location(0, 1), Location(1, 0), Location(1, 1)])
  }

  @Test
  func knows_openNeighbors_when_some_selected() {
    let game = Game(2, ["F", "U", "N", "D"])
    let sut = Solver(minimumAnswerSize: 4, vocabulary: game.vocabulary, grid: game.grid)
    var selection = Selection(game.grid)

    selection.select(Location(0, 1))
    selection.select(Location(1, 0))
    selection.select(Location(0, 0))

    #expect(sut.availableNeighbors(selection) == [Location(1, 1)])
  }

  @Test
  func finds_all_answers_in_1_cell_board() {
    let game = Game(1, ["A"], Vocabulary(["A"]))
    let sut = Solver(minimumAnswerSize: 1, vocabulary: game.vocabulary, grid: game.grid)
    #expect(matches(sut.answers(), Answers(["A"])))
  }

  @Test()
  func finds_all_answers_in_4_cell_board() {
    let game = Game(2, ["F", "U", "N", "D"], Vocabulary(["FUN", "FUND"]))
    let sut = Solver(minimumAnswerSize: 1, vocabulary: game.vocabulary, grid: game.grid)

    #expect(matches(sut.answers(), Answers(["FUN", "FUND"])))
  }

  @Test
  func finds_all_answers_in_16_cell_board() {
    let game = Game(
      4,
      [
       "F", "U", "N", "D",
       "E", "R", "S", "T",
       "W", "H", "I", "L",
       "E", "A", "L", "S",
      ],
      Vocabulary(["FUN", "FUND", "FUNDER", "FUNDERS", "WHILE", "UNDER", "TWIST", "BECKON", "ERSTWHILE"].sorted())
    )
    let sut = Solver(minimumAnswerSize: 1, vocabulary: game.vocabulary, grid: game.grid)

    #expect(matches(sut.answers(), Answers(["FUN", "FUND", "FUNDER", "FUNDERS", "UNDER", "WHILE", "ERSTWHILE"])))
  }

  @Test
  func finds_all_the_answers_over_given_size() {
    let game = Game(
      4,
      ["F", "U", "N", "D", "E", "R", "S", "T", "W", "H", "I", "L", "E", "A", "L", "S"],
      Vocabulary(["FUND", "FUNDER", "FUNDERS", "WHILE", "UNDER", "TWIST", "BECKON", "ERSTWHILE"].sorted())
    )
    let sut = Solver(minimumAnswerSize: 6, vocabulary: game.vocabulary, grid: game.grid)

    #expect(matches(sut.answers(), Answers(["FUNDER", "FUNDERS", "ERSTWHILE"])))
  }

  @Test
  func doesnt_reuse_letters_in_finding_all_answers() {
    let game = Game(2, ["T", "Z", "E", "D"], Vocabulary(["ZED", "TZETZE"]))
    let sut = Solver(minimumAnswerSize: 1, vocabulary: game.vocabulary, grid: game.grid)

    #expect(matches(sut.answers(), Answers(["ZED"])))
  }

  @Test
  func doesnt_reuse_letters_in_finding_all_answers_concoction() {
    let game = Game(
      5,
      split(["IUHHS", "NKBHA", "JEEEU", "CNZEI", "ROBKT"]),
      Vocabulary(["CONE", "CONCOCT", "CONCOCTION"])
    )
    let sut = Solver(minimumAnswerSize: 1, vocabulary: game.vocabulary, grid: game.grid)

    #expect(matches(sut.answers(), Answers(["CONE"])))
  }
}
