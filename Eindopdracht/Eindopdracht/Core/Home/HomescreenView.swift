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
                HStack(spacing: 8) {
                    Image("cat-icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 120)
                    Text("Cat Tinder")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .cornerRadius(20)
                .shadow(radius: 5)
                ZStack {
                    SwipeGestureView(currentIndex: $currentIndex, maxIndex: Int.max) {
                        CardView(viewModel: cardViewModel)
                    }
                    .onAppear {
                        // Load initial data
                        cardViewModel.loadCatData()
                        cardViewModel.loadUserData()
                    }
                    .onChange(of: currentIndex) { newValue in
                        // Load new data when index changes
                        cardViewModel.loadCatData()
                        cardViewModel.loadUserData()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 40)
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            currentIndex = (currentIndex + 1) % Int.max
                        }
                    }) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.red)
                            .padding()
                    }
                    Button(action: {
                        isShowingMapSheet = true
                    }) {
                        Image(systemName: "map")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                            .padding()
                    }
                    .sheet(isPresented: $isShowingMapSheet) {
                        if let city = cardViewModel.userData?.location.city {
                            MapSheetView(city: city)
                        } else {
                            Text("No city available")
                        }
                    }
                    Button(action: {
                        withAnimation {
                            currentIndex = (currentIndex - 1) % Int.max
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                            .padding()
                    }
                    
                    Spacer()
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
                    Button(action: {
                        withAnimation {
                            currentIndex = (currentIndex + 1) % Int.max
                        }
                    }) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.red)
                            .padding()
                    }
                    Button(action: {
                        isShowingMapSheet = true
                    }) {
                        Image(systemName: "map")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                            .padding()
                    }
                    .sheet(isPresented: $isShowingMapSheet) {
                        if let city = cardViewModel.userData?.location.city {
                            MapSheetView(city: city)
                        } else {
                            Text("No city available")
                        }
                    }
                    Button(action: {
                        withAnimation {
                            currentIndex = (currentIndex - 1 + Int.max) % Int.max
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                            .padding()
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 20)
            }
        }
    }
}



#Preview {
    HomescreenView()
}
