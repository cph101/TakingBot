import Foundation

enum Args: String {
    case string = "[^\\s]+?"
    case number = "-?(\\d+(\\.\\d*)?|\\.\\d+)"
    case boolean = "true|false"
    case time = "\\b(\\d+)\\s*(d|m|y|h|s|day|month|year|hour|second)s?\\b|\\binf\\b"
    case user = "<@!?(\\d{17,20})>|\\d{17,20}"
    case code = "`([^`]+)`|```([\\s\\S]+?)```"
}

class MatchablePresentation {
    public let args: [Args]
    public let names: [String]
    public let prefix: String

    init(_ args: [Args], _ names: [String], _ prefix: String) {
        self.args = args
        self.names = names
        self.prefix = prefix
    }

    /// Extracts an argument value based on its type and position.
    func extractArg(matched: NSTextCheckingResult, index: Int, from input: String) -> Any? {
        guard index < args.count else { return nil }
        let type = args[index]
        let rangeIndex = index + 2
        guard matched.numberOfRanges > rangeIndex,
              let range = Range(matched.range(at: rangeIndex), in: input) else { return nil }
        let value = String(input[range])

        switch type {
        case .number:
            return Double(value)
        case .boolean:
            return value == "true"
        case .time:
            return value == "inf" ? "indefinite" : value
        case .user:
            return value.replacingOccurrences(of: "[<@!>]", with: "", options: .regularExpression)
        case .code:
            return value.replacingOccurrences(of: "`{1,3}", with: "", options: .regularExpression)
        case .string:
            return value
        }
    }

    /// Retrieves the alias (command name) used in the input.
    func usedAlias(matched: NSTextCheckingResult, from input: String) -> String? {
        guard matched.numberOfRanges > 1 else { return nil }
        let range = matched.range(at: 1)
        return Range(range, in: input).map { String(input[$0]) }
    }

    /// Escapes a string for safe use in regex patterns.
    private func escapeRegExpString(_ str: String) -> String {
        NSRegularExpression.escapedPattern(for: str)
    }

    /// Builds the regular expression for matching the command and arguments.
    func buildRegex() -> NSRegularExpression? {
        let escapedPrefix = escapeRegExpString(prefix)
        let argPatterns = args.map { "(\($0.rawValue))?" }.joined(separator: " ")
        let pattern = "^\(escapedPrefix)(\(names.joined(separator: "|")))(?: \(argPatterns))?$"
        return try? NSRegularExpression(pattern: pattern, options: []);
    }

    // MARK: - Builder Class
    class Builder {
        private var args: [Args] = []
        private var names: [String] = []

        init(_ name: String) {
            names.append(name)
        }

        func addArg(_ type: Args) -> Self {
            args.append(type)
            return self
        }

        func addAlias(_ name: String) -> Self {
            names.append(name)
            return self
        }

        func build(prefix: String = ",") -> MatchablePresentation {
            return MatchablePresentation(args, names, prefix)
        }
    }
}
