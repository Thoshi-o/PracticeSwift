// method type 
enum Signal {
  case red
  case yellow
  case blue
  
  func colorMeaning () -> String {
    switch self {
      case .blue:
	return "Go"
      case .yellow:
        return "Warn or Go Safely if you can't stop"
      case .red :
        return "Stop"
    }
  }
}

let signal = Signal.yellow
print(signal.colorMeaning())
