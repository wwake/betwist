@testable import betwist
import Testing

struct ALocation {
  @Test
  func neighbor_in_same_column() {
    #expect(Location(0, 0).hasNeighbor(Location(0, 1), wrap: 4))
  }

  @Test
  func neighbor_in_same_row() {
    #expect(Location(1, 0).hasNeighbor(Location(0, 0), wrap: 4))
  }

  @Test
  func neighbor_touching_diagonally() {
    #expect(Location(1, 1).hasNeighbor(Location(0, 0), wrap: 4))
  }

  @Test
  func not_neighbor_when_too_far_away() {
    #expect(!Location(0, 0).hasNeighbor(Location(2, 0), wrap: 4 ))
  }

  @Test
  func hasNeighbor_is_symmetric() {
    #expect(Location(0, 0).hasNeighbor(Location(0, 1), wrap: 4))
    #expect(Location(0, 1).hasNeighbor(Location(0, 0), wrap: 4))

    #expect(!Location(0, 0).hasNeighbor(Location(0, 2), wrap: 4))
    #expect(!Location(0, 2).hasNeighbor(Location(0, 0), wrap: 4))
  }

  @Test
  func neighbor_in_wrapped_row() {
    #expect(Location(0, 1).hasNeighbor(Location(3, 1), wrap: 4))
  }

  @Test
  func neighbor_in_wrapped_column() {
    #expect(Location(2, 0).hasNeighbor(Location(2, 3), wrap: 4))
  }

  @Test
  func neighbor_touching_diagonally_when_wrapped() {
    #expect(Location(0, 0).hasNeighbor(Location(3, 3), wrap: 4))
  }

  @Test
  func all_neighbors_have_positive_locations() {
    let sut = Location(0, 0)
    let result = sut.allNeighbors(wrap: 4)
    #expect(result == [
      Location(3, 3), Location(3, 0), Location(3, 1),
      Location(0, 3), Location(0, 1),
      Location(1, 3), Location(1, 0), Location(1, 1),
    ])
  }

  @Test
  func moves_by_a_delta() {
    #expect(Location(3, 5).movedBy(DeltaLocation(1, -3), wrap: 6) == Location(4, 2))
    #expect(Location(1, 2).movedBy(DeltaLocation(5, -3), wrap: 4) == Location(2, 3))
  }
}
