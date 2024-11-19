import Algorithms
import Foundation

struct LetterGrid {
  let size: Int
  let grid: [[String]]

  init(_ size: Int, _ source: [String]) {
    self.size = size

    self.grid = source.chunks(ofCount: size).map(Array.init)
  }

  subscript(_ row: Int, _ column: Int) -> String {
    grid[row %% size][column %% size]
  }

  func hasNeighbors(_ location1: Location, _ location2: Location) -> Bool {
    location1.hasNeighbor(location2, wrap: size)
  }
}
