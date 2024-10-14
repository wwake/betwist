@testable import betwist
import Testing

struct ASelection {
  @Test
  func starts_empty() {
    let grid = LetterGrid(2, ["A", "B", "C", "D"])
    let sut = Selection(grid)
    #expect(sut.count == 0)
    #expect(sut.guess.isEmpty)
  }

  @Test
  func can_start_new_word() {
    let grid = LetterGrid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)

    sut.select(Location(1, 0))

    #expect(sut.count == 1)
    #expect(sut.guess == "C")
  }

  @Test
  func can_extend_word_by_selecting_neighbor() {
    let grid = LetterGrid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)
    sut.select(Location(0, 1))

    sut.select(Location(0, 0))

    #expect(sut.count == 2)
    #expect(sut.guess == "BA")
  }

  @Test
  func selecting_non_neighbor_starts_new_word() {
    let grid = LetterGrid(4, [
      "A", "B", "C", "D",
      "E", "F", "G", "H",
      "I", "J", "K", "L",
      "M", "N", "O", "P",
    ])
    var sut = Selection(grid)
    sut.select(Location(0, 0))

    sut.select(Location(0, 2))

    #expect(sut.count == 1)
    #expect(sut.guess == "C")
  }

  @Test
  func selecting_existing_location_unwinds_selection() {
    let grid = LetterGrid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)
    sut.select(Location(0, 1))
    sut.select(Location(0, 0))

    sut.select(Location(0, 1))

    #expect(sut.count == 1)
    #expect(sut.guess == "B")
  }

  @Test
  func can_clear() {
    let grid = LetterGrid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)
    sut.select(Location(1, 0))

    sut.clear()

    #expect(sut.count == 0)
  }

  @Test
  func has_type_for_each_location() {
    let grid = LetterGrid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)
    sut.select(Location(0, 0))
    sut.select(Location(0, 1))
    sut.select(Location(1, 0))

    #expect(sut.type(Location(0, 0)) == .first)
    #expect(sut.type(Location(0, 1)) == .middle)
    #expect(sut.type(Location(1, 0)) == .last)
    #expect(sut.type(Location(1, 1)) == .neighbor)
  }

  @Test
  func has_type_for_neighbors() {
    let grid = LetterGrid(4, [String](repeating: "X", count: 16))
    var sut = Selection(grid)
    sut.select(Location(1, 1))

    #expect(sut.type(Location(0, 0)) == .neighbor)
    #expect(sut.type(Location(0, 1)) == .neighbor)
    #expect(sut.type(Location(0, 2)) == .neighbor)
    #expect(sut.type(Location(0, 3)) == .open)

    #expect(sut.type(Location(1, 0)) == .neighbor)
    #expect(sut.type(Location(1, 1)) == .last)
    #expect(sut.type(Location(1, 2)) == .neighbor)
    #expect(sut.type(Location(1, 3)) == .open)

    #expect(sut.type(Location(2, 0)) == .neighbor)
    #expect(sut.type(Location(2, 1)) == .neighbor)
    #expect(sut.type(Location(2, 2)) == .neighbor)
    #expect(sut.type(Location(2, 3)) == .open)

    #expect(sut.type(Location(3, 0)) == .open)
    #expect(sut.type(Location(3, 1)) == .open)
    #expect(sut.type(Location(3, 2)) == .open)
    #expect(sut.type(Location(3, 3)) == .open)
  }

  @Test
  func ignores_selection_while_blocked() {
    let grid = LetterGrid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)
    sut.blocked = true

    sut.select(Location(0, 0))

    #expect(sut.guess.isEmpty)
  }

  @Test
  func clearing_removes_block() {
    let grid = LetterGrid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)
    sut.blocked = true

    sut.clear()
    sut.select(Location(0, 0))

    #expect(sut.guess == "A")
  }
}
