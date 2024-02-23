import Foundation

class CardViewModel: ObservableObject {
    @Published var catData: CatData?
    
    func loadData() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search") else {
            print("ERROR: Failed to construct a URL from string")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("ERROR: Fetch failed: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("ERROR: failed to get data from URLSession")
                return
            }
            do {
                let catData = try JSONDecoder().decode([CatData].self, from: data)
                DispatchQueue.main.async {
                    self.catData = catData.first
                }
            } catch {
                print("ERROR: decoding failed: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
