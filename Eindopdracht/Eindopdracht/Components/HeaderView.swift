
import SwiftUI

struct HeaderView: View {
    
    let FRAMEHEIGHT: CGFloat = 120
    let FRAMEWIDTH: CGFloat = 100
    
    var body: some View {
        HStack(spacing: 8) {
            Image("cat-icon")
                .resizable()
                .scaledToFill()
                .frame(width: FRAMEWIDTH, height: FRAMEHEIGHT)
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
