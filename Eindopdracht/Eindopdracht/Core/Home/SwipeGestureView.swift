import SwiftUI

struct SwipeGestureView<Content: View>: View {
    let content: Content
    let maxIndex: Int
    
    @Binding var currentIndex: Int
    @State private var offset: CGSize = .zero
    
    init(currentIndex: Binding<Int>, maxIndex: Int, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._currentIndex = currentIndex
        self.maxIndex = maxIndex
    }
    
    var body: some View {
        content
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        offset = value.translation
                    }
                    .onEnded { value in
                        withAnimation {
                            let threshold: CGFloat = 100
                            if offset.width > threshold && currentIndex > 0 {
                                currentIndex -= 1
                                AudioPlayer.playDislikeSound()
                            } else if offset.width < -threshold && currentIndex < maxIndex {
                                currentIndex += 1
                                AudioPlayer.playLikeSound()
                            }
                            offset = .zero
                        }
                    }
            )
    }
}
