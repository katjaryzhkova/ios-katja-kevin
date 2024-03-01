import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // image
                    Image("cat-icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 180)
                    
                    // form fields
                    VStack(spacing: 24) {
                        InputView(text: $email,
                                  title: "Email Address",
                                  placeholder: "name@example.com")
                        .autocapitalization(.none)
                        
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  isSecureField: true)
                    }
                    .padding(.horizontal, 48)
                    .padding(.top, 12)
                    
                    // sign in button
                    
                    Button {
                        AudioPlayer.playGenericButtonSound()
                        Task {
                            try
                            await viewModel.signIn(withEmail: email, password: password)
                        }
                        
                    } label: {
                        HStack {
                            Text("SIGN IN")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width / (horizontalSizeClass == .compact && verticalSizeClass == .regular ? 1 : 2.5) - 32, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .cornerRadius(10)
                    .padding(.top, 24)
                    
                    Spacer()
                    
                    // sign up button
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden()
                        
                    } label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account?")
                            Text("Sign up")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .font(.system(size: 14))
                    }
                }
            }
        }
    }
}

// MARK: - AuthenticationFormProtocol

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView()
}
