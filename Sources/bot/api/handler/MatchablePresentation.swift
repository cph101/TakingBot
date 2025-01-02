import Foundation

struct Args {
    let pattern: String

    static let string = Args(pattern: "[^\\s]+?")
    static let number = Args(pattern: "-?(\\d+(\\.\\d*)?|\\.\\d+)")
    static let boolean = Args(pattern: "true|false")
    static let time = Args(pattern: "\\b(\\d+)\\s*(d|m|y|h|s|day|month|year|hour|second)s?\\b|\\binf\\b")
    static let user = Args(pattern: "<@!?(\\d{17,20})>|\\d{17,20}")
    static let code = Args(pattern: "`([^`]+)`|```([\\s\\S]+?)```")

}


class MatchablePresentation {
    public let args: [Args]
    public let flags: [[String]]
    public let names: [String]
    public let prefix: String

    init(args: [Args], flags: [[String]], names: [String], prefix: String) {
        self.args = args
        self.flags = flags
        self.names = names
        self.prefix = prefix
    }

    // Extract positional arguments
    func extractArg(matched: NSTextCheckingResult, index: Int, from input: String) -> String? {
        guard index < args.count else { return nil }
        let rangeIndex = index + 2
        guard matched.numberOfRanges > rangeIndex,
              let range = Range(matched.range(at: rangeIndex), in: input) else { return nil }
        return String(input[range])
    }

    // Extract flags based on alias
    func extractFlag(matched: NSTextCheckingResult, flagAlias: String, from input: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: "\\b\(NSRegularExpression.escapedPattern(for: flagAlias))\\b", options: .caseInsensitive)
        let range = NSRange(input.startIndex..<input.endIndex, in: input)
        return regex?.firstMatch(in: input, options: [], range: range) != nil
    }

    // Build regex for matching command, args, and flags
    func buildRegex() -> NSRegularExpression? {
        let escapedPrefix = NSRegularExpression.escapedPattern(for: prefix)
        let commandNames = names.joined(separator: "|") // Match any of the command names (aliases)
        let argPatterns = args.map { "(\($0.pattern))?" }.joined(separator: " ") // Optional positional args
        
        // Correct flag patterns
        let flagPatterns = flags.map { "(?:" + $0.map { "\\b\($0)\\b" }.joined(separator: "|") + ")" }.joined(separator: "|")

        // Combine the regex: prefix + command name + optional args + optional flags
        let fullPattern = "^\(escapedPrefix)(\(commandNames))(?: \(argPatterns))?(?: \(flagPatterns))?$"
        //print("Regex Pattern: \(fullPattern)")
        return try? NSRegularExpression(pattern: fullPattern)
    }


    // Match input against the built regex
    func matchesInput(_ input: String) -> NSTextCheckingResult? {
        guard let regex = buildRegex() else { return nil }
        let range = NSRange(input.startIndex..<input.endIndex, in: input)
        return regex.firstMatch(in: input, options: [], range: range)
    }

    class Builder {
        private var args: [Args] = []  // Positional arguments
        private var flags: [[String]] = [] // Flags and their aliases
        private var names: [String] = [] // Command names and aliases

        init(_ name: String) {
            names.append(name)
        }

        func addArg(_ type: Args) -> Self {
            args.append(type)
            return self
        }

        func addFlag(_ aliases: [String]) -> Self {
            guard !aliases.isEmpty else {
                fatalError("Flag aliases cannot be empty.")
            }
            flags.append(aliases)
            return self
        }

        func addAlias(_ name: String) -> Self {
            names.append(name)
            return self
        }

        func build(prefix: String = ",") -> MatchablePresentation {
            return MatchablePresentation(args: args, flags: flags, names: names, prefix: prefix)
        }
    }

}
