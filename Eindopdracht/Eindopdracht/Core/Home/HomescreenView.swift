import SwiftUI

/**
 The main application view composed of a cat's profile as well as the
 three interaction buttons (like, dislike, and show location).
 */
struct HomescreenView: View {
    /**
     Used to determine whether the phone is in landscape or portrait mode.
     */
    @Environment(\.verticalSizeClass) var sizeClass: UserInterfaceSizeClass?
    
    /**
     The currently displayed cat profile.
     */
    @StateObject var cardViewModel = CardViewModel()
        
    /**
     Whether the map is currently being displayed or not.
     */
    @State private var isShowingMapSheet = false
    
    var body: some View {
        // Portrait mode
        if sizeClass == .regular {
            VStack {
                HeaderView()
                ZStack {
                    SwipeGestureView(cardViewModel: cardViewModel)
                }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                HStack {
                    TinderButtonsView(isShowingMapSheet: $isShowingMapSheet, cardViewModel: cardViewModel)
                        .padding(.bottom, 20)
                }
                    .padding(.bottom, 20)
            }
        // Landscape mode
        } else {
            HStack {
                HStack(spacing: 8) {
                    Image("cat-icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 120)
                }
                    .cornerRadius(20)
                    .shadow(radius: 5)
                ZStack {
                    SwipeGestureView(cardViewModel: cardViewModel)
                }
                VStack {
                    TinderButtonsView(isShowingMapSheet: $isShowingMapSheet, cardViewModel: cardViewModel)
                }
            }
        }
    }
}


#Preview {
    HomescreenView()
}
