import SwiftUI

struct CardView: View {
    let name: String
    let age: Int
    @StateObject var viewModel: CardViewModel
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: UIScreen.main.bounds.width - 40, height: 430)
                .overlay(
                    VStack {
                        if let catData = viewModel.catData,
                           let url = URL(string: catData.url) {
                            AsyncImageView(url: url)
                                .frame(width: UIScreen.main.bounds.width - 60, height: 320)
                                .cornerRadius(20)
                                .shadow(radius: 5)
                        } else {
                            ProgressView() // Placeholder while loading
                                .padding()
                        }
                        HStack {
                            Text(name)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            Text("-  \(age) years old")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                )
                .cornerRadius(20)
                .shadow(radius: 5)
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}

#Preview {
    CardView(name: "John", age: 2, viewModel: CardViewModel())
}
