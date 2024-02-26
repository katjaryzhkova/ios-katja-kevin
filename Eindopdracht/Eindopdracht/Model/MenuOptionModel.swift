import Foundation

enum SideMenuOptionModel: Int, CaseIterable {
    case home
    case profile
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "Profile"
        }
    }
    
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
