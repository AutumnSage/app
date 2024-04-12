import SwiftUI
import WebKit

// WebView component to load article content
struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

// FlashcardView setup to display content from the article URL
struct FlashcardView: View {
    let url: String
    @State private var scale: CGFloat = 1.0

    var body: some View {
        GeometryReader { geometry in
            WebView(url: URL(string: url)!)
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 0.5), value: scale)
                .onTapGesture {
                    self.scale = self.scale > 1 ? 1 : 1.5
                }
                .gesture(DragGesture()
                            .onChanged { _ in self.scale = 1.3 }
                            .onEnded { _ in self.scale = 1 })
        }
        .navigationBarTitle("Article", displayMode: .inline)
    }
}
