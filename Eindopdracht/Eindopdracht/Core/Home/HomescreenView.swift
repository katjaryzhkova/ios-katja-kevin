import SwiftUI

struct HomescreenView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    @StateObject var cardViewModel = CardViewModel()
    
    @State private var currentIndex: Int = 0
    @State private var isShowingMapSheet = false
    
    var body: some View {
        // Prefered way of checking orientation of the device, within the if is the portrait mode
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            VStack {
                HeaderView()
                ZStack {
                    SwipeGestureView(currentIndex: $currentIndex, maxIndex: Int.max) {
                        CardView(viewModel: cardViewModel)
                    }
                    .onAppear {
                        // Load initial data
                        cardViewModel.loadCatData()
                        cardViewModel.loadUserData()
                    }
                    .onChange(of: currentIndex) {
                        // Load new data when index changes
                        cardViewModel.loadCatData()
                        cardViewModel.loadUserData()
                    }
                    
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
                HStack {
                    TinderButtons(currentIndex: $currentIndex, isShowingMapSheet: $isShowingMapSheet, cardViewModel: cardViewModel)
                        .padding(.bottom, 20)
                }
                .padding(.bottom, 20)
            }
        }
        else {
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
                    SwipeGestureView(currentIndex: $currentIndex, maxIndex: Int.max) {
                        CardView(viewModel: cardViewModel)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
                VStack {
                    Spacer()
                    TinderButtons(currentIndex: $currentIndex, isShowingMapSheet: $isShowingMapSheet, cardViewModel: cardViewModel)
                        .padding(.bottom, 20)
                }
                .padding(.bottom, 20)
            }
        }
    }
}



#Preview {
    HomescreenView()
}
