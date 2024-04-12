import SwiftUI

struct ExplainerView2: View {
    var goToNextPage: () -> Void
    
    // The names of your images
    let imageNames = ["Graphic2", "Graphic3", "Graphic4"]
    @State private var selectedImageIndex = 0
    
    // Timer to change the image every few seconds
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let backgroundColor = Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0)
    
    var body: some View {
        ZStack {
            // Background image
            Image("ExplainerNew2") // Use the ID of your background image in the asset catalog
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                GeometryReader { geometry in
                    TabView(selection: $selectedImageIndex) {
                        ForEach(imageNames.indices, id: \.self) { index in
                            Image(imageNames[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width) // Adjust width to match GeometryReader
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    // Use dynamic height based on the available space or a fixed value appropriate for your layout
                    .frame(height: geometry.size.height * 0.4)
                    .onReceive(timer) { _ in
                        withAnimation {
                            selectedImageIndex = (selectedImageIndex + 1) % imageNames.count
                        }
                    }
                }
                .padding(.top, 150) // Adjust this padding as needed
                Spacer() // Additional spacing as needed
                Button(action: goToNextPage) {
                    Text("Log In")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Bold", size: 19))
                        .frame(minWidth: 0, maxWidth: 300)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
                .padding(.bottom, 122)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onDisappear {
            self.timer.upstream.connect().cancel()
        }
    }
}
