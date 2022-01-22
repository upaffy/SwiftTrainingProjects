//
//  ContactListView.swift
//  ContactListSUI
//
//  Created by Pavlentiy on 12.11.2021.
//

import SwiftUI

struct ContactListView: View {
    let persons: [Person]
    
    var body: some View {
        List(persons, id: \.self) { person in
            NavigationLink(person.fullName) {
                DetailedInfoView(person: person)
            }
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView(persons: Person.getPersons())
    }
}
