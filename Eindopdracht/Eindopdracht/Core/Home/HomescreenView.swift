import SwiftUI

struct HomescreenView: View {
    let names = ["John Doe", "Alice", "Bob", "Emily", "David"]
    @State private var currentIndex: Int = 0
    
    var body: some View {
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
                SwipeGestureView(currentIndex: $currentIndex, maxIndex: names.count - 1) {
                    ForEach(names.indices, id: \.self) { index in
                        CardView(name: names[index], age: Int.random(in: 0...20), viewModel: CardViewModel())
                            .opacity(index == currentIndex ? 1 : 0)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        currentIndex = (currentIndex + 1) % names.count
                    }
                }) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.red)
                        .padding()
                }
                Button(action: {
                    withAnimation {
                        currentIndex = (currentIndex - 1 + names.count) % names.count
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


#Preview {
    HomescreenView()
}
