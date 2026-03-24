import NitroModules
import UIKit
import MarkdownView
import MarkdownParser

final class HybridDiffs : HybridDiffsSpec {
    var view: UIView = UIView()
    private let scrollView = UIScrollView()
    private let markdownTextView = MarkdownTextView()
    private var lastContent: String = ""

    var content: String = ""
    var colorScheme: String = "dark"
    var contentInset: ContentInset?
    var showsBlockHeaders: Bool?

    override init() {
        super.init()

        markdownTextView.theme.fonts.body = .systemFont(ofSize: 16)
        markdownTextView.theme.fonts.code = .monospacedSystemFont(ofSize: 14, weight: .regular)

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

        markdownTextView.theme.showsBlockHeaders = showsBlockHeaders ?? true

        guard content != lastContent else { return }
        lastContent = content

        let preprocessed = MarkdownTextView.PreprocessedContent(
            markdown: content,
            theme: .default
        )
        markdownTextView.setMarkdown(preprocessed)
    } 
}
