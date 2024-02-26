
import SwiftUI

struct TinderButtons: View {
    @Binding var currentIndex: Int
    @Binding var isShowingMapSheet: Bool
    @ObservedObject var cardViewModel: CardViewModel
    
    let FONTSIZE: CGFloat = 60
    
    var body: some View {
        Spacer()
        Button(action: {
            withAnimation {
                currentIndex = (currentIndex + 1) % Int.max
            }
        }) {
            Image(systemName: "heart.fill")
                .font(.system(size: FONTSIZE))
                .foregroundColor(.red)
                .padding()
        }
        Button(action: {
            isShowingMapSheet = true
        }) {
            Image(systemName: "map")
                .font(.system(size: FONTSIZE))
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
            withAnimation {
                currentIndex = (currentIndex - 1) % Int.max
            }
        }) {
            Image(systemName: "xmark")
                .font(.system(size: FONTSIZE))
                .foregroundColor(.blue)
                .padding()
        }
        Spacer()
    }
}

