//
//  ExtendedContactListView.swift
//  ContactListSUI
//
//  Created by Pavlentiy on 12.11.2021.
//

import SwiftUI

struct ExtendedContactListView: View {
    let persons: [Person]
    
    var body: some View {
        List(persons, id: \.self) { person in
            Section {
                InfoRowView(imageSystemName: "phone", contactData: person.phoneNumber)
                InfoRowView(imageSystemName: "tray", contactData: person.email)
            } header: {
                Text(person.fullName)
            }

        }
    }
}

struct ExtendedContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ExtendedContactListView(persons: Person.getPersons())
    }
}
