//
//  ContentView.swift
//  Outread
//
//  Created by Dhruv Sirohi on 17/1/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var hasCompletedOnboarding = false
    @State private var products: [Product] = []
    var body: some View {
        if hasCompletedOnboarding {
            MainTabView(products: products)
        } else {
            OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
        }
    }
}

// Onboarding flow
struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            ExplainerView1( goToLogin: {
                withAnimation {
                currentPage = 2 // Animate to the login view
                }// Update `currentPage` or navigate to the login view// Assuming 2 is the index for the login view
            },
            goToNext: {
                withAnimation {
                currentPage = 1 // Animate to the login view
                }
                // Update `currentPage` to show the next explainer page or content
                // Assuming 1 is the index for the next content
            })
                .tag(0)
            ExplainerView2(goToNextPage: { withAnimation {
                self.goToNextPage()
            } })
                .tag(1)
            LoginView(onLoginSuccess: { withAnimation {
                self.hasCompletedOnboarding = true
            } })
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    private func goToNextPage() {
        if currentPage < 2 {
            currentPage += 1
        }
    }
}

// Main content with bottom navigation
struct MainTabView: View {
    var products: [Product] // Use the shared articles
    var body: some View {
        TabView {
            MainPageView()
                .tabItem {
                    Label("", systemImage: "house")
                }
            SearchView()
                .tabItem {
                    Label("", systemImage: "magnifyingglass")
                }
            BookmarkView(products: products)
                .environmentObject(BookmarkManager())
                .tabItem {
                    Label("", systemImage: "bookmark")
                }
            SettingsView()
                .tabItem {
                    Label("", systemImage: "gear")
                }
        }
    }
}


struct SettingsView: View {
    var body: some View {
        Text("Settings Content")
    }
}
