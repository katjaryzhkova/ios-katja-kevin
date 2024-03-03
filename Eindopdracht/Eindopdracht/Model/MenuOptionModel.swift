import Foundation

/**
 This enumeration contains all links from the navigation menu.
 */
enum SideMenuOptionModel: Int, CaseIterable {
    /**
     The tinder view.
     */
    case home
    
    /**
     The profile view.
     */
    case profile
    
    /**
     The navigation link's title.
     */
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "Profile"
        }
    }
    
    /**
     The navigation link's SF Symbol.
     */
    var systemImageName: String {
        switch self {
        case .home:
            return "house"
        case .profile:
            return "person"
        }
    }
}

// assign id to each case (needed for looping)
extension SideMenuOptionModel: Identifiable {
    var id: Int { return self.rawValue }
}
