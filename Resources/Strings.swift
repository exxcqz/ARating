// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Movies {
    internal enum Now {
      /// Now
      internal static let title = L10n.tr("Localizable", "movies.now.title")
    }
    internal enum Top {
      /// Top
      internal static let title = L10n.tr("Localizable", "movies.top.title")
    }
  }

  internal enum Tabbar {
    internal enum Bookmarks {
      /// Bookmarks
      internal static let title = L10n.tr("Localizable", "tabbar.bookmarks.title")
    }
    internal enum Search {
      /// Search
      internal static let title = L10n.tr("Localizable", "tabbar.search.title")
    }
    internal enum Top {
      /// Top
      internal static let title = L10n.tr("Localizable", "tabbar.top.title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
