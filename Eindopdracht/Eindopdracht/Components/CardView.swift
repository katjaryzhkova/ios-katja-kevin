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
                            if let urlString = viewModel.catData?.url, let url = URL(string: urlString) {
                                AsyncImage(url: url)
                                    .frame(width: UIScreen.main.bounds.width - 60, height: 320)
                                    .cornerRadius(20)
                                    .shadow(radius: 5)
                            } else {
                                ProgressView()
                                    .padding()
                            }
                            HStack {
                                Text(viewModel.userData?.name.first ?? "")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)
                                Text("-  \(Int((viewModel.userData?.dob.age ?? 0) / 8)) years old")
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
                    .frame(width: UIScreen.main.bounds.width - 300, height: UIScreen.main.bounds.height - 40)
                    .overlay(
                        VStack {
                            if let urlString = viewModel.catData?.url, let url = URL(string: urlString) {
                                AsyncImage(url: url)
                                    .frame(width: UIScreen.main.bounds.width - 320, height: UIScreen.main.bounds.height - 80)
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
                                Text("-  \(Int((viewModel.userData?.dob.age ?? 0) / 8)) years old")
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
