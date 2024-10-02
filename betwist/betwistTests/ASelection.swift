@testable import betwist
import Testing

struct ASelection {
  @Test
  func starts_empty() {
    let grid = Grid(2, ["A", "B", "C", "D"])
    let sut = Selection(grid)
    #expect(sut.count == 0)
    #expect(sut.guess.isEmpty)
  }

  @Test
  func can_start_new_word() {
    let grid = Grid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)

    sut.select(Location(1, 0))

    #expect(sut.count == 1)
    #expect(sut.guess == "C")
  }

  @Test
  func can_extend_word_by_selecting_neighbor() {
    let grid = Grid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)
    sut.select(Location(0, 1))

    sut.select(Location(0, 0))

    #expect(sut.count == 2)
    #expect(sut.guess == "BA")
  }

  @Test
  func selecting_non_neighbor_starts_new_word() {
    let grid = Grid(4, [
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
    let grid = Grid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)
    sut.select(Location(0, 1))
    sut.select(Location(0, 0))

    sut.select(Location(0, 1))

    #expect(sut.count == 1)
    #expect(sut.guess == "B")
  }

  @Test
  func can_clear() {
    let grid = Grid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)
    sut.select(Location(1, 0))

    sut.clear()

    #expect(sut.count == 0)
  }

  @Test
  func has_type_for_each_location() {
    let grid = Grid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)
    sut.select(Location(0, 0))
    sut.select(Location(0, 1))
    sut.select(Location(1, 0))

    #expect(sut.type(Location(0, 0)) == .first)
    #expect(sut.type(Location(0, 1)) == .middle)
    #expect(sut.type(Location(1, 0)) == .last)
    #expect(sut.type(Location(1, 1)) == .open)
  }

  @Test
  func ignores_selection_while_blocked() {
    let grid = Grid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)
    sut.blocked = true

    sut.select(Location(0, 0))

    #expect(sut.guess.isEmpty)
  }

  @Test
  func clearing_removes_block() {
    let grid = Grid(2, ["A", "B", "C", "D"])
    var sut = Selection(grid)
    sut.blocked = true

    sut.clear()
    sut.select(Location(0, 0))

    #expect(sut.guess == "A")
  }
}
