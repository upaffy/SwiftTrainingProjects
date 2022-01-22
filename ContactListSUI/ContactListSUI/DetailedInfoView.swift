//
//  DetailedInfoView.swift
//  ContactListSUI
//
//  Created by Pavlentiy on 12.11.2021.
//

import SwiftUI

struct DetailedInfoView: View {
    let person: Person
    
    var body: some View {
        List {
            HStack {
                Spacer()
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 150, height: 150)
                Spacer()
            }
            .padding()
            InfoRowView(imageSystemName: "phone", contactData: person.phoneNumber)
            InfoRowView(imageSystemName: "tray", contactData: person.email)
        }
        .navigationTitle(person.fullName)
    }
}

struct DetailedInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedInfoView(
            person: Person(
                name: "David",
                surname: "Johnson",
                email: "wekuttoinnetou-3106@yopmail.com",
                phoneNumber: "8912929384"
            )
        )
    }
}
