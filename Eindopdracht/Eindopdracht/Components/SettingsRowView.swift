import SwiftUI

/**
 The label displayed for rows in the profile page.
 */
struct SettingsRowView: View {
    /**
     The name of the SF Symbol displayed before the label
     */
    let imageName: String
    
    /**
     The label's text
     */
    let title: String
    
    /**
     The color which is applied to the symbol
     */
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
}
