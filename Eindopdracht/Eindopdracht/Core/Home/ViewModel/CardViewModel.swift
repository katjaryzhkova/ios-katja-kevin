import Foundation

struct CatData: Codable {
    let url: String
}

struct UserData: Codable {
    let results: [UserResult]
}

struct UserResult: Codable {
    let gender: String
    let name: UserName
    let location: UserLocation
    let email: String
    let dob: UserDOB
    let picture: UserProfilePicture
}

struct UserName: Codable {
    let title: String
    let first: String
    let last: String
}

struct UserLocation: Codable {
    let street: UserStreet
    let city: String
    let state: String
    let country: String
}

struct UserStreet: Codable {
    let number: Int
    let name: String
}

struct UserDOB: Codable {
    let date: String
    let age: Int
}

struct UserProfilePicture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

class CardViewModel: ObservableObject {
    @Published var catData: CatData?
    @Published var userData: UserResult?
    
    func loadCatData() {
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
    
    func loadUserData() {
        guard let url = URL(string: "https://randomuser.me/api/") else {
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
                let userData = try JSONDecoder().decode(UserData.self, from: data)
                DispatchQueue.main.async {
                    self.userData = userData.results.first
                }
            } catch {
                print("ERROR: decoding failed: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
