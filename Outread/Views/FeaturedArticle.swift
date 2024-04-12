//
//  FeaturedArticle.swift
//  Outread
//
//  Created by Dhruv Sirohi on 27/3/2024.
//

import SwiftUI

struct FeaturedReadView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading) {
            if let imageUrl = article.featuredMediaUrl, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.5)
                }
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
            }

            Text(article.title.rendered)
                .font(.headline)
                .padding([.leading, .trailing, .bottom])

            // Other details you want to show for the featured article
        }
        .background(Color.blue.opacity(0.3))
        .cornerRadius(10)
        .padding()
    }
}
