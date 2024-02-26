import SwiftUI


struct CardView: View {
    @ObservedObject var viewModel: CardViewModel
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
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
                                Text(viewModel.userData?.name.first ?? "")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)
                                Text("-  \(viewModel.userData?.dob.age ?? 0) years old")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    )
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .onAppear {
                        viewModel.loadCatData()
                    }
                    .onChange(of: viewModel.userData?.name.first) {
                        viewModel.loadCatData()
                    }
            }
        } else {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width - 300, height: 300)
                    .overlay(
                        VStack {
                            if let catData = viewModel.catData,
                               let url = URL(string: catData.url) {
                                AsyncImageView(url: url)
                                    .frame(width: UIScreen.main.bounds.width - 100, height: 250)
                                    .cornerRadius(20)
                                    .shadow(radius: 5)
                            } else {
                                ProgressView() // Placeholder while loading
                                    .padding()
                            }
                            HStack {
                                Text(viewModel.userData?.name.first ?? "")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)
                                Text("-  \(viewModel.userData?.dob.age ?? 0) years old")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    )
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .onAppear {
                        viewModel.loadCatData()
                    }
                    .onChange(of: viewModel.userData?.name.first) {
                        viewModel.loadCatData()
                    }
            }
        }
    }
}
