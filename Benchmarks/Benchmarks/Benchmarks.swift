import Benchmark
import CoreData
import Foundation
import SwiftData

@Model final public class Item {
  var timestamp: Date
  
  public init(timestamp: Date = .now) {
    self.timestamp = timestamp
  }
}

public func modelContext() throws -> ModelContext {
  let schema = Schema([Item.self])
  let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try ModelContainer(
    for: schema,
    configurations: configuration
  )
  return ModelContext(container)
}

let input = Int64(1)

let benchmarks = {
  
  Benchmark.defaultConfiguration.metrics = .default
  Benchmark.defaultConfiguration.timeUnits = .microseconds
  Benchmark.defaultConfiguration.maxDuration = .seconds(86400)
  Benchmark.defaultConfiguration.maxIterations = .count(1)
  
  Benchmark("Benchmark") { benchmark in
    benchmark.startMeasurement()
    
    let modelContext = try modelContext()
    
    benchmark.stopMeasurement()
    blackHole(modelContext)
  }
  
}
