import NitroModules
import UIKit
import MarkdownView
import MarkdownParser

final class HybridDiffs : HybridDiffsSpec {
    var view: UIView = UIView()
    private let scrollView = UIScrollView()
    private let markdownTextView = MarkdownTextView()
    private var lastContent: String = ""
    private var lastTheme: Theme?

    var content: String = ""
    var colorScheme: String = "dark"
    var contentInset: ContentInset?
    var showsBlockHeaders: Bool?
    var theme: Theme?

    override init() {
        super.init()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        markdownTextView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(markdownTextView)
        NSLayoutConstraint.activate([
            markdownTextView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            markdownTextView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            markdownTextView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            markdownTextView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ])
    }

    func afterUpdate() {
        if let contentInset {
            let insets = UIEdgeInsets(top: contentInset.top, left: 0, bottom: contentInset.bottom, right: 0)
            scrollView.contentInset = insets
            scrollView.scrollIndicatorInsets = insets
        }

        var mdTheme = MarkdownTheme.default
        applyTheme(theme, to: &mdTheme)
        mdTheme.showsBlockHeaders = showsBlockHeaders ?? true
        markdownTextView.theme = mdTheme

        guard content != lastContent else { return }
        lastContent = content

        let preprocessed = MarkdownTextView.PreprocessedContent(
            markdown: content,
            theme: mdTheme
        )
        markdownTextView.setMarkdown(preprocessed)
    }

    // MARK: - Theme Application

    private func applyTheme(_ theme: Theme?, to mdTheme: inout MarkdownTheme) {
        guard let theme else { return }

        // Fonts
        if let fonts = theme.fonts {
            if let size = fonts.bodySize {
                mdTheme.fonts.body = .systemFont(ofSize: CGFloat(size))
            }
            if let size = fonts.codeSize {
                mdTheme.fonts.code = .monospacedSystemFont(ofSize: CGFloat(size), weight: .regular)
            }
            if let size = fonts.codeInlineSize {
                mdTheme.fonts.codeInline = .monospacedSystemFont(ofSize: CGFloat(size), weight: .regular)
            }
            if let size = fonts.titleSize {
                mdTheme.fonts.title = .systemFont(ofSize: CGFloat(size), weight: .semibold)
            }
            if let size = fonts.largeTitleSize {
                mdTheme.fonts.largeTitle = .systemFont(ofSize: CGFloat(size), weight: .bold)
            }
            if let size = fonts.footnoteSize {
                mdTheme.fonts.footnote = .systemFont(ofSize: CGFloat(size))
            }
        }

        // Colors
        if let colors = theme.colors {
            if let hex = colors.body { mdTheme.colors.body = UIColor(hex: hex) }
            if let hex = colors.highlight { mdTheme.colors.highlight = UIColor(hex: hex) }
            if let hex = colors.emphasis { mdTheme.colors.emphasis = UIColor(hex: hex) }
            if let hex = colors.code { mdTheme.colors.code = UIColor(hex: hex) }
            if let hex = colors.codeBackground { mdTheme.colors.codeBackground = UIColor(hex: hex) }
            if let hex = colors.selectionTint { mdTheme.colors.selectionTint = UIColor(hex: hex) }
        }

        // Spacings
        if let spacings = theme.spacings {
            if let v = spacings.final { mdTheme.spacings.final = CGFloat(v) }
            if let v = spacings.general { mdTheme.spacings.general = CGFloat(v) }
            if let v = spacings.list { mdTheme.spacings.list = CGFloat(v) }
            if let v = spacings.cell { mdTheme.spacings.cell = CGFloat(v) }
        }

        // Sizes
        if let sizes = theme.sizes {
            if let v = sizes.bullet { mdTheme.sizes.bullet = CGFloat(v) }
        }

        // Table
        if let table = theme.table {
            if let v = table.cornerRadius { mdTheme.table.cornerRadius = CGFloat(v) }
            if let v = table.borderWidth { mdTheme.table.borderWidth = CGFloat(v) }
            if let hex = table.borderColor { mdTheme.table.borderColor = UIColor(hex: hex) }
            if let hex = table.headerBackgroundColor { mdTheme.table.headerBackgroundColor = UIColor(hex: hex) }
            if let hex = table.cellBackgroundColor { mdTheme.table.cellBackgroundColor = UIColor(hex: hex) }
            if let hex = table.stripeCellBackgroundColor { mdTheme.table.stripeCellBackgroundColor = UIColor(hex: hex) }
        }

        // Image
        if let image = theme.image {
            if let v = image.cornerRadius { mdTheme.image.cornerRadius = CGFloat(v) }
            if let v = image.maxWidthFraction { mdTheme.image.maxWidthFraction = CGFloat(v) }
            if let hex = image.placeholderColor { mdTheme.image.placeholderColor = UIColor(hex: hex) }
        }

        // Diff
        if let diff = theme.diff {
            if let mode = diff.displayMode {
                switch mode {
                case .sidebyside: mdTheme.diff.displayMode = .sideBySide
                case .unified: mdTheme.diff.displayMode = .unified
                }
            }
            if let behavior = diff.scrollBehavior {
                switch behavior {
                case .bothaxes: mdTheme.diff.scrollBehavior = .bothAxes
                case .horizontalonly: mdTheme.diff.scrollBehavior = .horizontalOnly
                }
            }
            if let v = diff.contextCollapseThreshold { mdTheme.diff.contextCollapseThreshold = Int(v) }
            if let v = diff.visibleContextLines { mdTheme.diff.visibleContextLines = Int(v) }
            if let hex = diff.gutterBackground { mdTheme.diff.gutterBackground = UIColor(hex: hex) }
            if let hex = diff.gutterText { mdTheme.diff.gutterText = UIColor(hex: hex) }
            if let hex = diff.backgroundColor { mdTheme.diff.backgroundColor = UIColor(hex: hex) }
            if let hex = diff.addedLineBackground { mdTheme.diff.addedLineBackground = UIColor(hex: hex) }
            if let hex = diff.removedLineBackground { mdTheme.diff.removedLineBackground = UIColor(hex: hex) }
            if let hex = diff.addedHighlightBackground { mdTheme.diff.addedHighlightBackground = UIColor(hex: hex) }
            if let hex = diff.removedHighlightBackground { mdTheme.diff.removedHighlightBackground = UIColor(hex: hex) }
            if let hex = diff.hunkHeaderBackground { mdTheme.diff.hunkHeaderBackground = UIColor(hex: hex) }
            if let hex = diff.hunkHeaderText { mdTheme.diff.hunkHeaderText = UIColor(hex: hex) }
            if let hex = diff.separatorColor { mdTheme.diff.separatorColor = UIColor(hex: hex) }
            if let v = diff.borderWidth { mdTheme.diff.borderWidth = CGFloat(v) }
            if let hex = diff.borderColor { mdTheme.diff.borderColor = UIColor(hex: hex) }
        }
    }
}

// MARK: - UIColor Hex Extension

private extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let length = hexSanitized.count
        let r, g, b, a: CGFloat

        switch length {
        case 6:
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            a = 1.0
        case 8:
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        default:
            r = 0; g = 0; b = 0; a = 1.0
        }

        self.init(displayP3Red: r, green: g, blue: b, alpha: a)
    }
}
