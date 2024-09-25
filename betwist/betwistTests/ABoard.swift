@testable import betwist
import Testing

struct ABoard {
  let bigBoard = "ABCDEFGHIJKLMNOP".map { String($0) }

  @Test
  func knows_its_size() {
    let board = Board(2, ["A", "B", "C", "D"])
    #expect(board.size == 2)
  }

  @Test
  func fills_row_by_row_from_a_sequence() {
    let board = Board(2, ["A", "B", "C", "D"])
    #expect(board[0, 0] == "A")
    #expect(board[0, 1] == "B")
    #expect(board[1, 0] == "C")
    #expect(board[1, 1] == "D")
  }

  @Test
  func knows_its_contents() {
    let board = Board(4, bigBoard)
    #expect(board[0, 0] == board[0, 0])
    #expect(board[3, 3] == board[3, 3])
  }

  @Test
  func wraps_out_of_bound_indices() {
    let board = Board(4, bigBoard)
    #expect(board[0, 4] == board[0, 0])
    #expect(board[7, 3] == board[3, 3])
  }

  @Test
  func wraps_negative_indices() {
    let board = Board(4, bigBoard)
    #expect(board[0, 0] == board[0, -4])
    #expect(board[3, 3] == board[-1, 3])
  }

  @Test
  func identical_locations_are_not_neighbors() {
    let sut = Board(4, bigBoard)

    #expect(!sut.hasNeighbors(Location(0, 0), Location(0, 0)))
  }

  @Test
  func neighbors_when_close_together() {
    let sut = Board(4, bigBoard)
    #expect(sut.hasNeighbors(Location(0, 1), Location(3, 1)))
  }

  @Test
  func not_neighbors_when_too_far_away() {
    let sut = Board(4, bigBoard)
    #expect(!sut.hasNeighbors(Location(0, 1), Location(2, 1)))
  }
}
