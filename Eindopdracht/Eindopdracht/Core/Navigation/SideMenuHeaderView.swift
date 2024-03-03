import SwiftUI

/**
 The navigation menu's header displaying the user's information.
 */
struct SideMenuHeaderView: View {
    /**
     The ``AuthViewModel`` is responsible for keeping track of the currently signed in user.
     */
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        if let user = viewModel.currentUser {
            HStack {
                Image(systemName: "person.circle.fill")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                    .frame(width: 48, height: 48)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(user.fullName)
                        .font(.subheadline)
                    
                    Text(user.email)
                        .font(.footnote)
                        .tint(.gray)
                }
            }
        }
    }
}

#Preview {
    let auth = AuthViewModel()
    auth.currentUser = User.mockUser
    return SideMenuHeaderView()
        .environmentObject(auth)
}
