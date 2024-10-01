@testable import betwist
import Testing

struct AGrid {
  let grid4x4 = "ABCDEFGHIJKLMNOP".map { String($0) }

  @Test
  func knows_its_size() {
    let sut = Grid(2, ["A", "B", "C", "D"])
    #expect(sut.size == 2)
  }

  @Test
  func fills_row_by_row_from_a_sequence() {
    let sut = Grid(2, ["A", "B", "C", "D"])
    #expect(sut[0, 0] == "A")
    #expect(sut[0, 1] == "B")
    #expect(sut[1, 0] == "C")
    #expect(sut[1, 1] == "D")
  }

  @Test
  func knows_its_contents() {
    let sut = Grid(4, grid4x4)
    #expect(sut[0, 0] == sut[0, 0])
    #expect(sut[3, 3] == sut[3, 3])
  }

  @Test
  func wraps_out_of_bound_indices() {
    let sut = Grid(4, grid4x4)
    #expect(sut[0, 4] == sut[0, 0])
    #expect(sut[7, 3] == sut[3, 3])
  }

  @Test
  func wraps_negative_indices() {
    let sut = Grid(4, grid4x4)
    #expect(sut[0, 0] == sut[0, -4])
    #expect(sut[3, 3] == sut[-1, 3])
  }

  @Test
  func identical_locations_are_not_neighbors() {
    let sut = Grid(4, grid4x4)

    #expect(!sut.hasNeighbors(Location(0, 0), Location(0, 0)))
  }

  @Test
  func neighbors_when_close_together() {
    let sut = Grid(4, grid4x4)
    #expect(sut.hasNeighbors(Location(0, 1), Location(3, 1)))
  }

  @Test
  func not_neighbors_when_too_far_away() {
    let sut = Grid(4, grid4x4)
    #expect(!sut.hasNeighbors(Location(0, 1), Location(2, 1)))
  }

  @Test
  func twist_left_knows_new_column_indexes() {
    var sut = Grid(4, grid4x4)
    sut.twist(.left)

    #expect(sut.rowIndexes == [0, 1, 2, 3])
    #expect(sut.columnIndexes == [1, 2, 3, 0])
  }

  @Test
  func twist_left_many_times_wraps() {
    var sut = Grid(4, grid4x4)
    sut.twist(.left)
    sut.twist(.left)
    sut.twist(.left)
    sut.twist(.left)

    #expect(sut.rowIndexes == [0, 1, 2, 3])
    #expect(sut.columnIndexes == [0, 1, 2, 3])
  }

  @Test
  func twist_right_knows_new_column_indexes() {
    var sut = Grid(4, grid4x4)
    sut.twist(.right)

    #expect(sut.rowIndexes == [0, 1, 2, 3])
    #expect(sut.columnIndexes == [3, 0, 1, 2])
  }

  @Test
  func twist_up_knows_new_row_indexes() {
    var sut = Grid(4, grid4x4)
    sut.twist(.up)

    #expect(sut.rowIndexes == [1, 2, 3, 0])
    #expect(sut.columnIndexes == [0, 1, 2, 3])
  }

  @Test
  func twist_down_knows_new_row_indexes() {
    var sut = Grid(4, grid4x4)
    sut.twist(.down)

    #expect(sut.rowIndexes == [3, 0, 1, 2])
    #expect(sut.columnIndexes == [0, 1, 2, 3])
  }
}