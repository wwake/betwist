@testable import betwist
import Testing

struct AGrid {
  let bigGrid = "ABCDEFGHIJKLMNOP".map { String($0) }

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
    let sut = Grid(4, bigGrid)
    #expect(sut[0, 0] == sut[0, 0])
    #expect(sut[3, 3] == sut[3, 3])
  }

  @Test
  func wraps_out_of_bound_indices() {
    let sut = Grid(4, bigGrid)
    #expect(sut[0, 4] == sut[0, 0])
    #expect(sut[7, 3] == sut[3, 3])
  }

  @Test
  func wraps_negative_indices() {
    let sut = Grid(4, bigGrid)
    #expect(sut[0, 0] == sut[0, -4])
    #expect(sut[3, 3] == sut[-1, 3])
  }

  @Test
  func identical_locations_are_not_neighbors() {
    let sut = Grid(4, bigGrid)

    #expect(!sut.hasNeighbors(Location(0, 0), Location(0, 0)))
  }

  @Test
  func neighbors_when_close_together() {
    let sut = Grid(4, bigGrid)
    #expect(sut.hasNeighbors(Location(0, 1), Location(3, 1)))
  }

  @Test
  func not_neighbors_when_too_far_away() {
    let sut = Grid(4, bigGrid)
    #expect(!sut.hasNeighbors(Location(0, 1), Location(2, 1)))
  }
}
