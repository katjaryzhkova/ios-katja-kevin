
import SwiftUI

struct AsyncImageView: View {
    let url: URL
    
    @State private var imageData: Data?
    
    var body: some View {
        if let imageData = imageData,
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            ProgressView() // Placeholder while loading
                .onAppear {
                    loadData()
                }
        }
    }
    
    private func loadData() {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                self.imageData = data
            }
        }.resume()
    }
}
