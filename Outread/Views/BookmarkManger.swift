import SwiftUI

class BookmarkManager: ObservableObject {
    @Published var bookmarkedProductIds: Set<Int> = []

    func isBookmarked(_ product: Product) -> Bool {
        bookmarkedProductIds.contains(product.id)
    }

    func toggleBookmark(for product: Product) {
        if isBookmarked(product) {
            bookmarkedProductIds.remove(product.id)
        } else {
            bookmarkedProductIds.insert(product.id)
        }
    }
}
