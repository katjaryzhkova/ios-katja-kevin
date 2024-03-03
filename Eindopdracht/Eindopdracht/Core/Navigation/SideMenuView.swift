import SwiftUI

/**
 The side menu which is used for navigating through the app's various views.
 */
struct SideMenuView: View {
    /**
     Whether the side menu is currently open or closed.
     */
    @Binding var isShowing: Bool
    
    /**
     The ID of the currently selected view.
     */
    @Binding var selectedTab: Int
    
    /**
     The currently selected view.
     */
    @State private var selectedOption: SideMenuOptionModel?
    
    var body: some View {
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture { isShowing.toggle() }
                
                HStack {
                    VStack(alignment: .leading, spacing: 32) {
                        SideMenuHeaderView()
                    
                        VStack {
                            ForEach(SideMenuOptionModel.allCases) { option in
                                Button(action: {
                                    AudioPlayer.playGenericButtonSound()
                                    onOptionTapped(option)
                                }, label: {
                                    SideMenuRowView(option: option, selectedOption: $selectedOption)
                                })
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(.white)
                    
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: isShowing)
    }
    
    /**
     Selects a view from the side menu's options and navigates to it.
     */
    private func onOptionTapped(_ option: SideMenuOptionModel) {
        selectedOption = option
        selectedTab = option.rawValue
        isShowing = false
    }
}

#Preview {
    let auth = AuthViewModel()
    auth.currentUser = User.mockUser
    return SideMenuView(isShowing: .constant(true), selectedTab: .constant(0))
        .environmentObject(auth)
}
