@testable import betwist
import Testing

struct Selection {
  let board: Board

  var selection = [(row: Int, column: Int)]()

  var count: Int {
    selection.count
  }

  var guess: String {
    selection
      .map { row, column in
        board[row, column]
      }
      .joined()
  }

  init(_ board: Board) {
    self.board = board
  }

  mutating func append(_ row: Int, _ column: Int) {
    selection.append((row: row, column: column))
  }
}

struct ASelection {
  @Test
  func starts_empty() {
    let board = Board(2, ["A", "B", "C", "D"])
    let selection = Selection(board)
    #expect(selection.count == 0)
    #expect(selection.guess.isEmpty)
  }

  @Test
  func can_start_new_word() {
    let board = Board(2, ["A", "B", "C", "D"])
    var selection = Selection(board)

    selection.append(1, 0)

    #expect(selection.count == 1)
    #expect(selection.guess == "C")
  }
}
