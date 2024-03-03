import SwiftUI

/**
 The application's root view.
 */
struct ContentView: View {
    /**
     Is the navigation menu currently displayed?
     */
    @State private var showMenu = false
    
    /**
     The currently open view.
     */
    @State private var selectedTab = 0
    
    /**
     The ``AuthViewModel`` is responsible for keeping track of the currently signed in user.
     */
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if viewModel.currentUser != nil {
            NavigationStack {
                ZStack {
                    VStack {
                        TabView(selection: $selectedTab) {
                            HomescreenView()
                                .tag(0)
                            
                            ProfileView()
                                .tag(1)
                        }
                    }
                    
                    SideMenuView(isShowing: $showMenu, selectedTab: $selectedTab)
                }
                .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            AudioPlayer.playGenericButtonSound()
                            showMenu.toggle()
                        }, label: {
                            Image(systemName: "line.3.horizontal")
                        })
                    }
                }
            }
        } else {
            LoginView()
        }
    }
}

#Preview {
    let auth = AuthViewModel()
    auth.currentUser = User.mockUser
    return ContentView()
        .environmentObject(auth)
}
