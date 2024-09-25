@testable import betwist
import Testing

struct ASelection {
  @Test
  func starts_empty() {
    let board = Board(2, ["A", "B", "C", "D"])
    let sut = Selection(board)
    #expect(sut.count == 0)
    #expect(sut.guess.isEmpty)
  }

  @Test
  func can_start_new_word() {
    let board = Board(2, ["A", "B", "C", "D"])
    var sut = Selection(board)

    sut.select(Location(1, 0))

    #expect(sut.count == 1)
    #expect(sut.guess == "C")
  }

  @Test
  func can_extend_word_by_selecting_neighbor() {
    let board = Board(2, ["A", "B", "C", "D"])
    var sut = Selection(board)
    sut.select(Location(0, 1))

    sut.select(Location(0, 0))

    #expect(sut.count == 2)
    #expect(sut.guess == "BA")
  }

  @Test
  func selecting_non_neighbor_starts_new_word() {
    let board = Board(4, [
      "A", "B", "C", "D",
      "E", "F", "G", "H",
      "I", "J", "K", "L",
      "M", "N", "O", "P",
    ])
    var sut = Selection(board)
    sut.select(Location(0, 0))

    sut.select(Location(0, 2))

    #expect(sut.count == 1)
    #expect(sut.guess == "C")
  }
}
