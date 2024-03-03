import SwiftUI

/**
 This view is displayed when the user has not yet logged in.
 */
struct LoginView: View {
    /**
     The email which is being input by the user.
     */
    @State private var email = ""
    
    /**
     The password which is being input by the user.
     */
    @State private var password = ""
    
    /**
     The ``AuthViewModel`` is responsible for keeping track of the currently signed in user.
     */
    @EnvironmentObject var viewModel: AuthViewModel
    
    /**
     Used to determine whether the phone is in landscape or portrait mode.
     */
    @Environment(\.verticalSizeClass) var sizeClass: UserInterfaceSizeClass?
    
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
                            await viewModel.signIn(withEmail: email, password: password)
                        }
                        
                    } label: {
                        HStack {
                            Text("SIGN IN")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width / (sizeClass == .regular ? 1 : 2.5) - 32, height: 48)
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

/**
 Form validation for the log in form.
 */
extension LoginView: AuthenticationFormProtocol {
    /**
     Checks whether the values in the form are valid or not.
     */
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
