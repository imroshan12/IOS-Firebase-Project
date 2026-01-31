//
//  AuthenticationView.swift
//  Login Project
//
//  Created by Sarvesh Roshan on 26/01/26.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Observation
import AuthenticationServices
import CryptoKit

@Observable
@MainActor
final class AuthenticationViewModel: NSObject {

    func signInGoogle() async throws {
        let helper = GoogleSignInHelper()
        
        let tokens = try await helper.getGoogleUser()
        try await AuthenticationManager.shared.signWithGoogle(tokens: tokens)
        
    }
    
    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        
        try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
    }
    
    func signInAnonymous() async throws {
        try await AuthenticationManager.shared.signInAnonymous()
    }
    
}

struct AuthenticationView: View {
    
    @State private var viewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            Button {
                Task {
                    do {
                        try await viewModel.signInAnonymous()
                        showSignInView = false
                    } catch {
                        print("Google Error \(error)")
                    }
                }
            } label: {
                Text("Sign in anonymously")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.orange)
                    .cornerRadius(10)
            }
            
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign in with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)) {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        showSignInView = false
                    } catch {
                        print("Google Error \(error)")
                    }
                }
            }
            
            Button {
                Task {
                    do {
                        try await viewModel.signInApple()
                        showSignInView = false
                    } catch {
                        print("Google Error \(error)")
                    }
                }
            } label: {
                SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                    .allowsHitTesting(false)
            }
            .frame(height: 55)
            
            Spacer()

        }
        .navigationTitle("Sign In")
        .padding()
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(showSignInView: .constant(false))
    }
}

