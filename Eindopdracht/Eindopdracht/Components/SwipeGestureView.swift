import SwiftUI

struct SwipeGestureView<Content: View>: View {
    let content: Content
    @Binding var currentIndex: Int
    let maxIndex: Int
    
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
                            } else if offset.width < -threshold && currentIndex < maxIndex {
                                currentIndex += 1
                            }
                            offset = .zero
                        }
                    }
            )
    }
}
