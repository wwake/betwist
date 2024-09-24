@testable import betwist
import Testing

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
