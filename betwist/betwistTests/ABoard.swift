@testable import betwist
import Testing

struct Board {
  let size: Int
  let board: [[String]]

  init(_ size: Int) {
    self.size = size
    self.board = [
      ["A", "B", "C", "D"],
      ["E", "F", "G", "H"],
      ["A", "B", "C", "D"],
      ["E", "F", "G", "H"],
    ]
  }

  subscript(_ row: Int, _ column: Int) -> String {
    var wrappedRow = row
    while wrappedRow < 0 {
      wrappedRow += size
    }

    var wrappedColumn = column
    while wrappedColumn < 0 {
      wrappedColumn += size
    }

    return board[wrappedRow % size][wrappedColumn % size]
  }
}

struct ABoard {
  @Test
  func knows_its_size() {
    let board = Board(4)
    #expect(board.size == 4)
  }

  @Test
  func knows_its_contents() {
    let board = Board(4)
    #expect(board[0, 0] == board[0, 0])
    #expect(board[3, 3] == board[3, 3])
  }

  @Test
  func wraps_out_of_bound_indices() {
    let board = Board(4)
    #expect(board[0, 4] == board[0, 0])
    #expect(board[7, 3] == board[3, 3])
  }

  @Test
  func wraps_negative_indices() {
    let board = Board(4)
    #expect(board[0, 0] == board[0, -4])
    #expect(board[3, 3] == board[-1, 3])
  }
}
