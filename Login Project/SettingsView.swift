//
//  SettingsView.swift
//  Login Project
//
//  Created by Sarvesh Roshan on 26/01/26.
//

import SwiftUI
import Observation

@MainActor
@Observable
final class SettingsViewModel {
    
    var authProviders: [AuthProviderOptions] = []
    var authUser: AuthDataResultModel? = nil
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func loadAuthUser() {
        self.authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }
    
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "emailUpdate@gmail.com"
        
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassowrd() async throws {
        let password = "Hello@123"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
    func linkGoogleAccount() async throws {
        let helper = GoogleSignInHelper()
        let tokens = try await helper.getGoogleUser()
        self.authUser = try await AuthenticationManager.shared.linkGoogle(tokens: tokens)
    }
    
    func linkAppleAccount() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        self.authUser = try await AuthenticationManager.shared.linkApple(tokens: tokens)
    }
    
    func linkEmail() async throws {
        let email = "hello123@gmail.com"
        let password = "Hello@123"
        self.authUser = try await AuthenticationManager.shared.linkEmail(email: email, password: password)
    }
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.delete()
    }
}

struct SettingsView: View {
    
    @State private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try viewModel.logOut()
                        showSignInView = true
                    } catch {
                        print("Error while logout")
                    }
                }
            }
            
            Button(role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    } catch {
                        print("Error while logout")
                    }
                }
            } label: {
                Text("Delete account")
            }

            
            if (viewModel.authProviders.contains(.email)) {
                emailSection
            }
            
            if (viewModel.authUser?.isAnonymous ?? false) {
                anonymousSection
            }
            
        }
        .onAppear() {
            viewModel.loadAuthProviders()
            viewModel.loadAuthUser()
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
    
}

extension SettingsView {
    private var emailSection: some View {
        Section {
            Button("Reset password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password reset")
                    } catch {
                        print("Error while reset")
                    }
                }
            }
            
            Button("Update email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("Email update")
                    } catch {
                        print("Error while reset")
                    }
                }
            }
            
            Button("Update password") {
                Task {
                    do {
                        try await viewModel.updatePassowrd()
                        print("Password update")
                    } catch {
                        print("Error while reset")
                    }
                }
            }
        } header: {
            Text("Email Functions")
        }

    }
    
    private var anonymousSection: some View {
        Section {
            Button("Link Google Account") {
                Task {
                    do {
                        try await viewModel.linkGoogleAccount()
                        print("Google linked")
                    } catch {
                        print("Error while linking google \(error)")
                    }
                }
            }
            
            Button("Link Apple Account") {
                Task {
                    do {
                        try await viewModel.linkAppleAccount()
                        print("Apple linked")
                    } catch {
                        print("Error while linking apple \(error)")
                    }
                }
            }
            
            Button("Link Email account") {
                Task {
                    do {
                        try await viewModel.linkEmail()
                        print("Email linked")
                    } catch {
                        print("Error while linking email \(error)")
                    }
                }
            }
        } header: {
            Text("Create account")
        }

    }
}
