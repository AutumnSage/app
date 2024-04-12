//
//  Category.swift
//  Outread
//
//  Created by Dhruv Sirohi on 2/4/2024.
//

import SwiftUI

struct CategoryView: View {
    let category: Category
    let gradient: LinearGradient

    init(category: Category) {
        self.category = category
        // Generate a random gradient for each CategoryView
        let colors = [Color.random, Color.random]
        self.gradient = LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var body: some View {
        Text(category.name)
            .foregroundColor(.white)
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            .background(gradient) // Use the gradient
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}

// You should remove the gradient property from the Category struct and the generateRandomGradient() method.

struct CategoriesScrollView: View {
    let categories: [Category]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories) { category in
                    CategoryView(category: category)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct Category: Identifiable, Decodable {
    let id: Int
    let name: String
    let parent: Int
    var gradient: LinearGradient?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case parent
    }

    // A custom initializer isn't strictly necessary unless you are doing additional setup.
    // The synthesized initializer by conforming to Decodable should be sufficient.
}

// Extension to add a method to generate random gradients.

// Extension to add the random color generation to the Color struct.
extension Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
