//
//  ExplainerView1.swift
//  Outread
//
//  Created by Dhruv Sirohi on 18/1/2024.
//

import SwiftUI

struct ExplainerView1: View {
    // Define your navigation actions here
    var goToLogin: () -> Void
    var goToNext: () -> Void
    let backgroundColor = Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0)
    
    var body: some View {
        ZStack {
            // Use the provided image as the background
            backgroundColor.edgesIgnoringSafeArea(.all)
            Image("ExplainerNew1") // Make sure to add this image to your Xcode asset catalog
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            // Overlay content
            VStack {
                // Spacer to push content upward
                // Adjust the 'minLength' value to position the buttons below the text on the image
                Spacer(minLength: 680)

                // Log In Button
                Button(action: goToLogin) {
                    Text("Log In")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Bold", size: 19))
                        .frame(minWidth: 0, maxWidth: 300)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 8) // Spacing between buttons

                // Next Button
                Button(action: goToNext) {
                    Text("Next")
                        .font(.custom("Poppins-Bold", size: 19))
                        .foregroundColor(.black)
                        .frame(minWidth: 0, maxWidth: 300)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer() // Spacer at the bottom to ensure buttons stay up
            }
            .padding(.horizontal) // Padding on the sides of the buttons
        }
    }
}
