import Foundation

// Define your Article struct including the embedded media.
struct Article: Codable, Identifiable {
    let id: Int
    let title: Rendered
    let content: Rendered
    var featuredMediaUrl: String? // Holds the URL for the featured image

    // Embedded struct to match the WordPress REST API structure for embedded media.
    private let _embedded: Embedded?

    // Convenience property to access the featured media URL directly from an Article instance.
    var featuredMedia: String? {
        _embedded?.wpFeaturedmedia?.first?.sourceUrl
    }

    enum CodingKeys: String, CodingKey {
        case id, title, content
        case _embedded = "_embedded"
    }

    struct Rendered: Codable {
        let rendered: String
    }

    struct Embedded: Codable {
        let wpFeaturedmedia: [FeaturedMedia]?

        enum CodingKeys: String, CodingKey {
            case wpFeaturedmedia = "wp:featuredmedia"
        }
    }

    struct FeaturedMedia: Codable {
        let sourceUrl: String?

        enum CodingKeys: String, CodingKey {
            case sourceUrl = "source_url"
        }
    }
}

struct Product: Codable {
    var id: Int
    var name: String
    var category: String
    var url: String
    var imageUrl: String  // Added imageUrl field

    private enum CodingKeys: String, CodingKey {
        case id, name, url, imageUrl
        case category = "categories"  // Assuming 'categories' is the key in the JSON response
    }
}
