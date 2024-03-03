import SwiftUI

/**
 A view where the user can edit their profile.
 */
struct EditProfileView: View {
    /**
     The full name which is being input by the user.
     */
    @State private var fullName = ""
    
    /**
     The current password which is being input by the user. This password is required to
     confirm the user's identity in order to update the user's profile.
     */
    @State private var currentPassword = ""
    
    /**
     The new password which is being input by the user.
     */
    @State private var newPassword = ""
    
    /**
     The dismiss property is used to navigate back from the edit page to the profile page.
     */
    @Environment(\.dismiss) var dismiss
    
    /**
     The ``AuthViewModel`` is responsible for keeping track of the currently signed in user.
     */
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // form fields
                VStack(spacing: 24) {
                    InputView(text: $fullName,
                              title: "Full Name",
                              placeholder: "Enter your name")
                    
                    InputView(text: $currentPassword,
                              title: "Current Password",
                              placeholder: "Enter your password")
                    .autocapitalization(.none)
                    
                    InputView(text: $newPassword,
                              title: "New Password",
                              placeholder: "Enter your password")
                    .autocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // save button
                Button {
                    AudioPlayer.playGenericButtonSound()
                    Task {
                        await viewModel.updateUserInfo(currentPassword: currentPassword, newPassword: newPassword, fullName: fullName)
                        dismiss()
                    }
                } label: {
                    HStack {
                        Text("SAVE")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
            }
        }
    }
}
            
// MARK: - AuthenticationFormProtocol

/**
 Form validation for the edit profile form.
 */
extension EditProfileView: AuthenticationFormProtocol {
    /**
     Checks whether the values in the form are valid or not.
     */
    var formIsValid: Bool {
        return !currentPassword.isEmpty
        && !newPassword.isEmpty
        && currentPassword.count > 5
        && newPassword.count > 5
        && !fullName.isEmpty
    }
}

#Preview {
    let auth = AuthViewModel()
    auth.currentUser = User.mockUser
    return EditProfileView()
        .environmentObject(auth)
}
