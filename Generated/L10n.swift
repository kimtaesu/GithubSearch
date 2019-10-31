// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// 취소
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// 확인
  internal static let ok = L10n.tr("Localizable", "ok")
  /// 검색어를 입력해 주세요.
  internal static let searchEmptyMessage = L10n.tr("Localizable", "search_empty_message")
  /// Search
  internal static let searchbarPlaceholder = L10n.tr("Localizable", "searchbar_placeholder")
  /// 좋아요
  internal static let tabbarFavoriteTitle = L10n.tr("Localizable", "tabbar_favorite_title")
  /// 검색
  internal static let tabbarSearchTitle = L10n.tr("Localizable", "tabbar_search_title")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
