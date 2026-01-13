
import KokuhakuCore
import ArgumentParser

@main
struct KokuhakuCLI: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "kokuhaku"
    )
    
    mutating func run() throws {
        print("kokuhaku CLI läuft")
    }
}

