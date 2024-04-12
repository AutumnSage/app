import SwiftUI
import Combine

// Assuming Article, BookmarkManager, and ArticleFlashcardView are defined elsewhere

struct MainPageView: View {
    @EnvironmentObject var appData: AppData // Use the shared articles
    @EnvironmentObject var bookmarkManager: BookmarkManager
    @State private var articles = [Article]()
    @State private var featuredProduct: Product? // Placeholder for your logic to set this
    @State private var cancellables = Set<AnyCancellable>()
    @State private var categories = [Category]()
    @State private var products: [Product] = []
    let backgroundColor = Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0)

    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ZStack {
                // Set the background color for the entire ZStack, including safe areas
                backgroundColor.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(alignment: .leading) {
                                Text("Home")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Medium", size: 36))
                                    .padding(.top, 8)
                                    .padding(.bottom, -4)
                                     // Apply padding to make text width similar to the rectangle width
                                
                                Rectangle()
                                    .frame(height: 4)
                                    .foregroundColor(Color(red: 150 / 255.0, green: 120 / 255.0, blue: 172 / 255.0))
                                    .padding(.trailing, 230)
                                     // Add some space between the text and the rectangle
                        
                                Text("Featured Read of the Day")
                                                    .font(.custom("Poppins-Medium", size: 20))
                                                    .foregroundColor(.white)
                                                    .padding(.vertical, 5) // Adjust padding as needed
                                                
                            }
                            .padding(.horizontal, 15)
                        LazyVStack {
                            
                            // Featured article section
                            if let featuredProduct = featuredProduct {
                                Section(header: Text("Featured")) {
                                    NavigationLink(destination: FlashcardView(url: featuredProduct.url)) {
                                        ProductRow(product: featuredProduct)
                                    }
                                }
                            }
                            
                            CategoriesScrollView(categories: categories)
                            
                            // Grid for articles
                            LazyVGrid(columns: columns, spacing: 20) {
                                List(products, id: \.id) { product in
                                                NavigationLink(destination: FlashcardView(url: product.url)) {
                                                    ProductRow(product: product)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                    .navigationTitle("") // Hide the default title
                    .navigationBarHidden(true)
                    .onAppear {
                       fetchProductsAndFeature()
                        loadCategories()
                        NetworkManager.shared.fetchProducts { fetchedProducts in
                            if let fetchedProducts = fetchedProducts {
                                self.products = fetchedProducts
                            }
                        }
                    }
                }
            }
        }
    // Separate function for featured article view to keep body clean
    private func fetchProductsAndFeature() {
        NetworkManager.shared.fetchProducts { fetchedProducts in
            if let fetchedProducts = fetchedProducts {
                self.products = fetchedProducts
                // Set the featured product, could be based on any logic
                self.featuredProduct = fetchedProducts.first // Example: setting the first product as featured
            }
        }
    }
    
    private func loadCategories() {
        let journalParentID = 59
        NetworkManager.shared.fetchCategories(excludingParentID: journalParentID)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching categories: \(error)")
                }
            }, receiveValue: { [self] fetchedCategories in
                self.categories = fetchedCategories
            })
            .store(in: &cancellables)
    }

}



class AppData: ObservableObject {
    @Published var articles: [Article] = []
    // ... other shared data
}
