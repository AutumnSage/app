//
//  ArticleRow.swift
//  Outread
//
//  Created by Dhruv Sirohi on 12/3/2024.
//

import SwiftUI

struct ProductRow: View {
    var product: Product
    @State private var isBookmarked: Bool = false
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 100, height: 100)
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text(product.category)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Button(action: toggleBookmark) {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(isBookmarked ? .blue : .gray)
            }
        }
    }
    
    
    
    private func toggleBookmark() {
        isBookmarked.toggle()
        // Persist the bookmark state as needed, e.g., save to user defaults or a database
    }
    
}
