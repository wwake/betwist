import Algorithms
import Foundation

struct LetterGrid {
  let size: Int
  let grid: [[String]]

  init(_ size: Int, _ source: any Sequence<String>) {
    self.size = size

    self.grid = Array(source).chunks(ofCount: size).map(Array.init)
  }

  subscript(_ row: Int, _ column: Int) -> String {
    grid[row %% size][column %% size]
  }

  func hasNeighbors(_ location1: Location, _ location2: Location) -> Bool {
    location1.hasNeighbor(location2, wrap: size)
  }
}
