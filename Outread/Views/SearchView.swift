import SwiftUI
import Combine


struct SearchView: View {
    @State private var articles = [Article]()
    @State private var searchText = ""
    @State private var cancellables = Set<AnyCancellable>()
    let backgroundColor = Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0)


    // Articles are now only shown when there is a search term entered
    var filteredArticles: [Article] {
        if searchText.isEmpty {
            return []
        } else {
            return articles.filter {
                $0.title.rendered.localizedCaseInsensitiveContains(searchText) ||
                $0.content.rendered.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Set the background color for the entire ZStack, including safe areas
                backgroundColor.edgesIgnoringSafeArea(.all)
                List(filteredArticles) { article in
                  //  NavigationLink(destination: FlashcardView(article: article)) {
                     //   ArticleRowContent(article: article)
                    }
                }
                .navigationTitle("Search Articles")
                .onAppear {
                   
                }
                .searchable(text: $searchText)
            }
        }
    }
        
    

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanCharacter() // Remove the '#'
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
// Extension for Color from a hex string remains unchanged.
