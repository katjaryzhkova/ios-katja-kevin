import SwiftUI

/**
 This view is displayed when the user has not yet logged in and
 wishes to create a new account.
 */
struct RegistrationView: View {
    /**
     The email which is being input by the user.
     */
    @State private var email = ""
    
    /**
     The full name which is being input by the user.
     */
    @State private var fullName = ""
    
    /**
     The password which is being input by the user.
     */
    @State private var password = ""
    
    /**
     The password which is being input by the user a second
     time to ensure the user did not make a typo.
     */
    @State private var confirmPassword = ""
    
    /**
     Used to determine whether the phone is in landscape or portrait mode.
     */
    @Environment(\.verticalSizeClass) var sizeClass: UserInterfaceSizeClass?
    
    /**
     The dismiss property is used to navigate back from the registration page to the login page.
     */
    @Environment(\.dismiss) var dismiss
    
    /**
     The ``AuthViewModel`` is responsible for keeping track of the currently signed in user.
     */
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
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
                    
                    InputView(text: $fullName,
                              title: "Full Name",
                              placeholder: "Enter your name")
                    
#if targetEnvironment(simulator) // workaround for password autofill bug
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: false)
                    .autocapitalization(.none)
#else
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
#endif
                    
                    ZStack(alignment: .trailing) {
                        InputView(text: $confirmPassword,
                                  title: "Confirm Password",
                                  placeholder: "Confirm your password",
                                  isSecureField: true)
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // sign in button
                Button {
                    AudioPlayer.playGenericButtonSound()
                    Task {
                        await viewModel.createUser(withEmail: email,
                                                       password: password,
                                                       fullName: fullName)
                    }
                } label: {
                    HStack {
                        Text("SIGN UP")
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
                
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text("Sign in")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

// MARK: - AuthenticationFormProtocol

/**
 Form validation for the sign up form.
 */
extension RegistrationView: AuthenticationFormProtocol {
    /**
     Checks whether the values in the form are valid or not.
     */
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
    }
}

#Preview {
    RegistrationView()
}
