import Foundation
import ArgumentParser
import KokuhakuCore

@main
struct KokuhakuCLI: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "kokuhaku",
        abstract: "KOKUHAKU CLI — create, list and play Kokuhaku flows.",
        subcommands: [Create.self, List.self, Play.self],
        defaultSubcommand: List.self
    )
}

struct Create: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Create a flow and print XML to stdout (placeholder).")

    @Option(name: [.short, .long], help: "Name of the flow.")
    var name: String

    @Option(name: [.customShort("s"), .long], help: "Short description.")
    var short: String?

    @Option(name: [.customShort("d"), .long], help: "Long description.")
    var description: String?

    @Option(name: [.customShort("u"), .long], help: "Duration per step (e.g. 30s, 5m). Placeholder.")
    var duration: String?

    @Flag(name: [.long], help: "Immediately pipe the created flow into play (placeholder).")
    var play: Bool = false

    func run() throws {
        // Placeholder: just prove CLI wiring + core types
        let step = KokuhakuStep(title: "Example Step", durationSeconds: 60)
        let set = KokuhakuSet(name: name, steps: [step])

        // Placeholder XML output
        print(#"""
<kokuhaku-flow version="1.0">
  <name>\#(set.name)</name>
  <summary>\#(short ?? "")</summary>
  <description>\#(description ?? "")</description>
  <steps>
    <step>
      <title>\#(step.title)</title>
      <duration seconds="\#(step.durationSeconds)"/>
    </step>
  </steps>
</kokuhaku-flow>
"""#)

        if play {
            // Placeholder: later we will pass data in-memory to Play
            fputs("NOTE: --play is not implemented yet.\n", stderr)
        }
    }
}

struct List: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "List flows found at path (placeholder).")

    @Option(name: [.customShort("f"), .long], help: "Local path (dir or file). If omitted, uses current directory.")
    var file: String?

    func run() throws {
        let path = file ?? FileManager.default.currentDirectoryPath
        print("Listing flows at: \(path) (placeholder)")
    }
}

struct Play: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Play a flow (placeholder).")

    @Option(name: [.customShort("m"), .long], help: "Mode: koku|haku|combi")
    var mode: String = "koku"

    @Option(name: [.customShort("f"), .long], help: "Flow file path (XML or ZIP).")
    var file: String?

    @Argument(help: "Optional flow name inside a container.")
    var name: String?

    func run() throws {
        print("Play mode: \(mode)")
        print("File: \(file ?? "(none)")  Name: \(name ?? "(none)")")
        print("(placeholder — next step will implement XML/ZIP parsing + runtime)")
    }
}
