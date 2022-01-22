//
//  ContentView.swift
//  ContactListSUI
//
//  Created by Pavlentiy on 12.11.2021.
//

import SwiftUI

struct ContentView: View {
    let persons = Person.getPersons()
    
    var body: some View {
        NavigationView {
            TabView{
                ContactListView(persons: persons)
                    .tabItem {
                        VStack{
                            Image(systemName: "person.3")
                            Text("Contacts")
                        }
                    }
                ExtendedContactListView(persons: persons)
                    .tabItem {
                        VStack {
                            Image(systemName: "phone")
                            Text("Numbers")
                        }
                    }
            }
            .navigationTitle("Contact List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
