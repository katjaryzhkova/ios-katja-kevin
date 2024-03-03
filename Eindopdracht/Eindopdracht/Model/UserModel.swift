import Foundation

/**
 This structure defines an identifiable user.
 */
struct User: Identifiable, Codable {
    /**
     The user's id.
     */
    let id: String
    
    /**
     The user's first and last name.
     */
    let fullName: String
    
    /**
     The user's email address.
     */
    let email: String
    
    /**
     The user's initials which are computed from the full name.
     */
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    /**
     A placeholder user used for previews.
     */
    static var mockUser = User(id: NSUUID().uuidString, fullName: "Test Test", email: "test@gmail.com")
}
