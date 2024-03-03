import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

/**
 The auth view model is responsible for keeping track of the currently signed in user.
 */
@MainActor
class AuthViewModel: ObservableObject {
    /**
     The current firebase auth session.
     */
    @Published var userSession: FirebaseAuth.User?
    
    /**
     The currently signed in user's profile.
     */
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    /**
     Tries to sign in using the provided email and password.
     
     @param withEmail The user's email address.
     @param password The user's password.
     */
    func signIn(withEmail email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    /**
     Tries to create a new user with the provided values.
     
     @param withEmail The user's email address.
     @param password The user's password.
     @param fullName The user's first and last name.
     */
    func createUser(withEmail email: String, password: String, fullName: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    /**
     Tries to update the currently signed in user's profile.
     
     @param currentPassword The user's current password which is used
     to verify the user's identity.
     @param newPassword The user's new password. If this value is the same
     as `currentPassword` then the user's password will not be updated.
     @param fullName The user's new full name. If this value is the same as
     the user's previous name it will not be updated in the database.
     */
    func updateUserInfo(currentPassword: String, newPassword: String, fullName: String) async {
        do {
            let currentUser = Auth.auth().currentUser
            let credential = EmailAuthProvider.credential(withEmail: currentUser?.email ?? "", password: currentPassword)
            try await currentUser?.reauthenticate(with: credential)
            try await currentUser?.updatePassword(to: newPassword)
            try await Firestore.firestore().collection("users").document(self.userSession?.uid ?? "").updateData([
                "fullName": fullName,
            ])
            self.currentUser = User(id: currentUser?.uid ?? "",fullName: fullName, email: currentUser?.email ?? "")
        } catch {
            print("DEBUG: Failed to edit user with error \(error.localizedDescription)")
        }
    }
    
    /**
     Tries to sign out.
     */
    func signOut() {
        do {
            try Auth.auth().signOut() // signs out user on backend
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil // wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    /**
     Tries to delete this user's account.
     
     @param password The user's password. This value is used to confirm the
     user's identity before deleting the account.
     */
    func deleteAccount(password: String) async {
        do {
            let uid = self.userSession?.uid ?? ""
            let currentUser = Auth.auth().currentUser
            let credential = EmailAuthProvider.credential(withEmail: currentUser?.email ?? "", password: password)
            try await currentUser?.reauthenticate(with: credential)
            try await currentUser?.delete()
            try await Firestore.firestore().collection("users").document(uid).delete()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to delete user with error \(error.localizedDescription)")
        }
    }
    
    /**
     Fetches the user's profile from the database.
     */
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
