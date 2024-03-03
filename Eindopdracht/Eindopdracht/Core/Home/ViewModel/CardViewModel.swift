import Foundation

/**
 Helper structure used to parse the cat API's response
 */
struct CatData: Codable {
    /**
     URL pointing to a random cat image obtained through the cat API.
     */
    let url: String
}

/**
 The viewmodel containing a randomly loaded cat image as well as some
 randomly generated user data.
 */
class CardViewModel: ObservableObject {
    /**
     URL pointing to a random cat image obtained through the cat API.
     */
    @Published var catImageUrl: URL?
    
    /**
     A set of randomly generated user data which is used for the cat profile.
     */
    @Published var userData: UserResult?
    
    /**
     Requests a random cat image from the cat API.
     */
    private func loadCatImage() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search") else {
            print("ERROR: Failed to construct a URL from string")
            return
        }
        
        // Try fetching the result from the URL
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("ERROR: Fetch failed: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("ERROR: failed to get data from URLSession")
                return
            }
            
            // Try extracting the image from the output
            do {
                // Decode JSON output
                let catData = try JSONDecoder().decode([CatData].self, from: data)
                DispatchQueue.main.async {
                    
                    // Convert output to URL if it's not nil
                    if let urlString = catData.first?.url {
                        self.catImageUrl = URL(string: urlString)
                    } else {
                        self.catImageUrl = nil
                    }
                }
            } catch {
                print("ERROR: cat decoding failed: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    /**
     Requests randomly generated user data from an online API which
     is used to create the cat's profile.
     */
    private func loadUserData() {
        guard let url = URL(string: "https://randomuser.me/api/") else {
            print("ERROR: Failed to construct a URL from string")
            return
        }
        
        // Try fetching the result from the URL
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
                // Decode JSON output
                let userData = try JSONDecoder().decode(UserData.self, from: data)
                DispatchQueue.main.async {
                    self.userData = userData.results.first
                }
            } catch {
                print("ERROR: user decoding failed: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    /**
     Loads a new cat image and randomly generated user profile.
     */
    func newCat() {
        loadCatImage()
        loadUserData()
    }
    
    /**
     The cat profile constructor. This loads both a random profile picture
     as well as a random user profile.
     */
    init() {
        newCat()
    }
}
