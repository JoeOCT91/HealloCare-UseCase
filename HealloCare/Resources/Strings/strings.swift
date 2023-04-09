// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Favorite   
  internal static let favorite = L10n.tr("Localizable", "favorite", fallback: "Favorite   ")
  /// Favorited
  internal static let favorited = L10n.tr("Localizable", "favorited", fallback: "Favorited")
  /// Favourites
  internal static let favourites = L10n.tr("Localizable", "favourites", fallback: "Favourites")
  /// Game Description
  internal static let gameDescription = L10n.tr("Localizable", "gameDescription", fallback: "Game Description")
  /// Games
  internal static let games = L10n.tr("Localizable", "games", fallback: "Games")
  /// metacritic: 
  internal static let metacritic = L10n.tr("Localizable", "metacritic", fallback: "metacritic: ")
  /// There is no favorites found.
  internal static let noFavoritesPlaceHolder = L10n.tr("Localizable", "noFavoritesPlaceHolder", fallback: "There is no favorites found.")
  /// Visit reddit
  internal static let visitReddit = L10n.tr("Localizable", "visitReddit", fallback: "Visit reddit")
  /// Visit website
  internal static let visitWebsite = L10n.tr("Localizable", "visitWebsite", fallback: "Visit website")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
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
