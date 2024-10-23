import SwiftUI

struct ColorChooser {
  func foregroundColor(_ type: SelectionType) -> Color {
    switch type {
    case .open, .neighbor:
      return Color(.cellForegroundOpen)
      
    default:
      return Color(.cellForegroundSelected)
    }
  }
  
  func backgroundColor(_ type: SelectionType, hue: Double) -> Color {
    switch type {
    case .open, .neighbor:
      return Color(hue: hue, saturation: 0.15, brightness: 1.0)
      
    default:
      return Color(.cellBackgroundSelected)
    }
  }
  
  func borderColor(_ type: SelectionType) -> Color {
    switch type {
    case .first:
      return Color(.cellBorderFirst)
      
    case .middle:
      return Color(.cellBorderMiddle)
      
    case .last:
      return Color(.cellBorderLast)
      
    case .neighbor:
      return Color(.cellBorderNeighbor)
      
    default:
      return Color(.cellBorderDefault)
    }
  }
  
  func borderWidth(_ type: SelectionType) -> CGFloat {
    switch type {
    case .first:
      return 3.0
      
    case .middle:
      return 1.0
      
    case .last:
      return 3.0
      
    case .neighbor:
      return 1.0
      
    default:
      return 1.0
    }
  }
}
