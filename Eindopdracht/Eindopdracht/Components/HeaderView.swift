
import SwiftUI

/**
 The app logo which is displayed in the header of many views.
 */
struct HeaderView: View {
    /**
     The height of the logo's cat
     */
    let logoHeight: CGFloat = 120
    
    /**
     The width of the logo's cat
     */
    let logoWidth: CGFloat = 100
    
    var body: some View {
        HStack(spacing: 8) {
            Image("cat-icon")
                .resizable()
                .scaledToFill()
                .frame(width: logoWidth, height: logoHeight)
            Text("Cat Tinder")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}


#Preview {
    HeaderView()
}
