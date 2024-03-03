import SwiftUI

/**
 An option within the navigation side bar.
 */
struct SideMenuRowView: View {
    /**
     The option this row represents.
     */
    let option: SideMenuOptionModel
    
    /**
     The option that is currently selected. This is used to determine
     whether this row is currently selected which is ultimately used
     to decide whether this row should be highlighted or not.
     */
    @Binding var selectedOption: SideMenuOptionModel?
    
    /**
     Whether this row is currently selected or not. This is used to
     decide whether this row should be highlighted or not.
     */
    private var isSelected: Bool {
        return selectedOption == option
    }
    
    var body: some View {
        HStack {
            Image(systemName: option.systemImageName)
                .imageScale(.small)
            
            Text(option.title)
                .font(.subheadline)
            
            Spacer()
        }
        .padding(.leading)
        .foregroundStyle(isSelected ? .blue : .primary)
        .frame(width: 216, height: 44)
        .background(isSelected ? .blue.opacity(0.15) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SideMenuRowView(option: .home, selectedOption: .constant(.home))
}
