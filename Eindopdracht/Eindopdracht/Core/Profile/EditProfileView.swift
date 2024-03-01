import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var fullName = ""
    @State private var currentPassword = ""
    @State private var newPassword = ""
    
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
                        try await viewModel.updateUserInfo(currentPassword: currentPassword, newPassword: newPassword, fullName: fullName)
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

extension EditProfileView: AuthenticationFormProtocol {
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
    auth.currentUser = User(id: "1", fullName: "Test Test", email: "test@gmail.com")
    return EditProfileView()
        .environmentObject(auth)
}
