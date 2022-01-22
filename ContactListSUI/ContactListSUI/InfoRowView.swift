//
//  InfoRowView.swift
//  ContactListSUI
//
//  Created by Pavlentiy on 12.11.2021.
//

import SwiftUI

struct InfoRowView: View {
    let imageSystemName: String
    let contactData: String
    
    var body: some View {
        HStack{
            Image(systemName: imageSystemName)
                .foregroundColor(.blue)
            Text(contactData)
                .textSelection(.enabled)
        }
    }
}

struct InfoRowView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRowView(imageSystemName: "phone", contactData: "987654321")
    }
}
