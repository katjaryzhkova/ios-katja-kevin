import SwiftUI

struct ContentView: View {
    @State private var showMenu = false
    @State private var selectedTab = 0
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
    auth.currentUser = User(id: "1", fullName: "Test Test", email: "test@gmail.com")
    return ContentView()
        .environmentObject(auth)
}
