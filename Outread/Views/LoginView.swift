import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginFailed: Bool = false
    var onLoginSuccess: () -> Void
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background image
                Image("Login Background 1") // Ensure this image is in your assets
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                // Login form content
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Welcome")
                                .font(.system(size: 34, weight: .heavy))
                                .foregroundColor(.white)
                            
                            Text("Sign in to continue.")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top, 35)
                    
                    Spacer()
                    
                    TextField("Email", text: $username)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(5.0)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(5.0)
                    
                    if loginFailed {
                        Text("Login failed. Please try again.")
                            .foregroundColor(.red)
                    }
                    
                    HStack {
                        Spacer()
                        Button("Sign in") {
                            authenticateUser(username: username, password: password)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    func authenticateUser(username: String, password: String) {
        // Authentication logic remains unchanged
        guard let url = URL(string: "https://out-read.com/wp-json/jwt-auth/v1/token") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    self.loginFailed = true
                    return
                }
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    self.onLoginSuccess()
                    
                    // Decode the JWT token from the response
                    if let data = data {
                        let decoder = JSONDecoder()
                        if let loginResponse = try? decoder.decode(LoginResponse.self, from: data) {
                            print("JWT Token: \(loginResponse.token)")
                            // You can also store the token securely here
                        } else {
                            print("Failed to decode JWT token")
                        }
                    }
                } else {
                    self.loginFailed = true
                }
            }
        }.resume()
    }
    
    struct LoginResponse: Codable {
        var token: String
    }
}
