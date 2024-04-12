//
//  BookmarkView.swift
//  Outread
//
//  Created by Dhruv Sirohi on 2/4/2024.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var bookmarkManager: BookmarkManager
    var products: [Product] // This should be passed from the main content view

    var body: some View {
        List(filteredProducts(), id: \.id) { product in
            ProductRow(product: product)
        }
        .navigationTitle("Bookmarks")
    }
    
    private func filteredProducts() -> [Product] {
        products.filter { bookmarkManager.isBookmarked($0) }
    }
}

