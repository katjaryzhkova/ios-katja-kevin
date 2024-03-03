import SwiftUI

/**
 This is a helper struct used to format input fields to look consistent
 throughout the application.
 */
struct InputView: View {
    /**
     The value the user inserted in the input field.
     */
    @Binding var text: String
    
    /**
     This is the label that is displayed above the input field.
     */
    let title: String
    
    /**
     A placeholder value that is displayed when nothing has yet been
     written in this input field.
     */
    let placeholder: String
    
    /**
     Whether this input should be marked as a secure (password) field.
     If this is set to true the user's input will be masked and hidden.
     */
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            
            Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}
