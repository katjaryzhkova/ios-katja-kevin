import SwiftUI

/**
 The three buttons displayed below the cat's profile (like, dislike, and map)
 */
struct TinderButtonsView: View {
    /**
     Whether the map is currently being displayed.
     */
    @Binding var isShowingMapSheet: Bool
    
    /**
     The currently displayed cat profile.
     */
    @ObservedObject var cardViewModel: CardViewModel
    
    /**
     The size of the buttons.
     */
    private let buttonSize: CGFloat = 60
    
    var body: some View {
        Spacer()
        Button(action: {
            cardViewModel.newCat()
            AudioPlayer.playLikeSound()
        }) {
            Image(systemName: "heart.fill")
                .font(.system(size: buttonSize))
                .foregroundColor(.red)
                .padding()
        }
        Button(action: {
            AudioPlayer.playGenericButtonSound()
            isShowingMapSheet = true
        }) {
            Image(systemName: "map")
                .font(.system(size: buttonSize))
                .foregroundColor(.green)
                .padding()
        }
        .sheet(isPresented: $isShowingMapSheet) {
            if let city = cardViewModel.userData?.location.city {
                MapSheetView(city: city)
            } else {
                MapSheetView(city: "New York")
            }
        }
        Button(action: {
            cardViewModel.newCat()
            AudioPlayer.playDislikeSound()
        }) {
            Image(systemName: "xmark")
                .font(.system(size: buttonSize))
                .foregroundColor(.blue)
                .padding()
        }
        Spacer()
    }
}

