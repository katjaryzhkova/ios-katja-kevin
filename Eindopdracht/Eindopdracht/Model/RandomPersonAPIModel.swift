import Foundation

/**
 This structure is the result that is returned by the random person API.
 It contains an array of ``UserResult``s.
 */
struct UserData: Codable {
    /**
     An array of results containing each randomly generated person.
     */
    let results: [UserResult]
}

/**
 A randomly generated person.
 */
struct UserResult: Codable {
    /**
     The person's name.
     */
    let name: UserName
    
    /**
     The person's location.
     */
    let location: UserLocation
    
    /**
     The person's age.
     */
    let dob: UserAge
}

/**
 A person's name.
 */
struct UserName: Codable {
    /**
     The person's first name.
     */
    let first: String
}

/**
 A person's location.
 */
struct UserLocation: Codable {
    /**
     The city this location is located in.
     */
    let city: String
}

/**
 The age of a person.
 */
struct UserAge: Codable {
    /**
     The equivalent age in years.
     */
    let age: Int
}
