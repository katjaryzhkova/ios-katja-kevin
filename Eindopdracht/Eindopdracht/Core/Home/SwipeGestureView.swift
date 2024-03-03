import SwiftUI

/**
 A swipable cat profile picture.
 */
struct SwipeGestureView: View {
    /**
     The currently displayed cat profile.
     */
    @ObservedObject var cardViewModel: CardViewModel
    
    /**
     How far the image has currently been swiped.
     */
    @State private var offset: CGSize = .zero
    
    /**
     How far the profile has to be swiped for the action to be confirmed.
     */
    private let threshold: CGFloat = 80
    
    var body: some View {
        CardView(viewModel: cardViewModel)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset.width = value.translation.width
                    }
                    .onEnded { value in
                        withAnimation {
                            if offset.width > threshold {
                                cardViewModel.newCat()
                                AudioPlayer.playDislikeSound()
                            } else if offset.width < -threshold {
                                cardViewModel.newCat()
                                AudioPlayer.playLikeSound()
                            }
                            
                            offset = .zero
                        }
                    }
            )
    }
}
