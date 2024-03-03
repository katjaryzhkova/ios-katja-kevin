import SwiftUI

/**
 This view displays the user's profile and allows the user to sign out as well as
 edit or delete their account.
 */
struct ProfileView: View {
    /**
     Whether the confirm account deletion alert is currently being displayed or not.
     */
    @State private var deletingAccountAlert = false
    
    /**
     The current password which is being input by the user. This password is required to
     confirm the user's identity in order to delete the account.
     */
    @State private var password = ""
    
    /**
     The ``AuthViewModel`` is responsible for keeping track of the currently signed in user.
     */
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationView {
            if let user = viewModel.currentUser {
                ZStack {
                    List {
                        NavigationLink(destination: EditProfileView()) {
                            Section {
                                HStack {
                                    Text(user.initials)
                                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .frame(width: 72, height: 72)
                                        .background(Color(.systemGray3))
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(user.fullName)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .padding(.top, 4)
                                        
                                        Text(user.email)
                                            .font(.footnote)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            
                        }
                        
                        Section("General") {
                            HStack {
                                SettingsRowView(imageName: "gear",
                                                title: "Version",
                                                tintColor: Color(.systemGray))
                                
                                Spacer()
                                
                                Text("1.0.0")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Section("Account") {
                            Button {
                                AudioPlayer.playGenericButtonSound()
                                viewModel.signOut()
                            } label: {
                                SettingsRowView(imageName: "arrow.left.circle.fill",
                                                title: "Sign Out",
                                                tintColor: .red)
                            }
                            
                            Button {
                                AudioPlayer.playGenericButtonSound()
                                deletingAccountAlert = true
                            } label: {
                                SettingsRowView(imageName: "xmark.circle.fill",
                                                title: "Delete Account",
                                                tintColor: .red)
                            }
                        }
                    }
                }
                .alert("Confirm Deletion", isPresented: $deletingAccountAlert, actions: {
                    SecureField("Password", text: $password)
                    Button {
                        AudioPlayer.playGenericButtonSound()
                    } label: {
                        Text("Cancel")
                    }
                    Button {
                        AudioPlayer.playGenericButtonSound()
                        Task {
                            await viewModel.deleteAccount(password: password)
                        }
                    } label: {
                        Text("Delete Account")
                    }
                },
                message: {
                    Text("Confirm your password to delete your account")
                })
            }
        }
    }
}
        
#Preview {
    let auth = AuthViewModel()
    auth.currentUser = User.mockUser
    return ProfileView()
        .environmentObject(auth)
}
