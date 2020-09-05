import Foundation

func fetchLocalIP () -> String {
  let process = Process()
  process.launchPath = "/usr/sbin/ipconfig"
  process.arguments = ["getifaddr", "en0"]
  
  // Create Pipe
  let pipe = Pipe()
  process.standardOutput = pipe
  process.standardError = pipe
  process.launch()
  
  
  let data = pipe.fileHandleForReading.readDataToEndOfFile
  return String(data: data(), encoding: .utf8) ?? "No connection"
}

print(fetchLocalIP())
