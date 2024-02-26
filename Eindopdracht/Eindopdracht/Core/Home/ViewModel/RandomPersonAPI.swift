import Foundation

struct UserData: Codable {
    let results: [UserResult]
}

struct UserResult: Codable {
    let gender: String
    let name: UserName
    let location: UserLocation
    let email: String
    let dob: UserDOB
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
