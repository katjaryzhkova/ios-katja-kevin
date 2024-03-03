import SwiftUI

/**
 This view is displays a cat's name, picture, and age.
 */
struct CardView: View {
    @ObservedObject var viewModel: CardViewModel
    
    /**
     Used to determine whether the phone is in landscape or portrait mode.
     */
    @Environment(\.verticalSizeClass) var sizeClass: UserInterfaceSizeClass?
    
    /**
     The random person API generates a random age which makes sense for humans,
     however the age it generates does not make sense for cats, since the lifespan of a
     cat is significantly shorter than that of a human. We multiply the randomly generated
     age by this factor to get an age that is far more plausible for a cat.
     */
    let catAgeFactor = 0.125;
    
    var body: some View {
        // Portrait mode
        if sizeClass == .regular {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 430)
                    .overlay(
                        VStack {
                            if let url = viewModel.catImageUrl {
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
                                Text("-  \(Int(Double(viewModel.userData?.dob.age ?? 0) * catAgeFactor)) years old")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    )
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }
        // Landscape mode
        } else {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: UIScreen.main.bounds.width - 300, height: UIScreen.main.bounds.height - 40)
                    .overlay(
                        VStack {
                            if let url = viewModel.catImageUrl {
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
                                
                                // Convert age to double first to be able to multiply it with the catAgeFactor
                                // to be able to convert the age into a value that is realistic for cats, then
                                // convert the result back into an int to round down the result.
                                Text("-  \(Int(Double(viewModel.userData?.dob.age ?? 0) * catAgeFactor)) years old")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    )
                    .cornerRadius(20)
                    .shadow(radius: 5)
            }
        }
    }
}
