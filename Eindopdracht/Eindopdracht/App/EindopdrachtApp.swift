import SwiftUI
import Firebase

/**
 The application's base class which initializes the app.
 */
@main
struct EindopdrachtApp: App {
    /**
     The ``AuthViewModel`` is responsible for keeping track of the currently signed in user.
     */
    @StateObject var viewModel = AuthViewModel()
    
    /**
     The constructor connects to Firebase.
     */
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
