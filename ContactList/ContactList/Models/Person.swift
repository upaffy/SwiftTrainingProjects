//
//  Person.swift
//  ContactList
//
//  Created by Pavlentiy on 08.09.2021.
//

struct Person {
    let name: String
    let surname: String
    let phoneNumber: String
    let email: String
    
    var fullName: String {
        "\(name) \(surname)"
    }
    
    static func getPersons() -> [Person] {
        let data = DataManager.shared
        
        let names = data.names.shuffled()
        let surnames = data.surnames.shuffled()
        let phoneNumbers = data.phoneNumbers.shuffled()
        let emails = data.emails.shuffled()
        
        var persons: [Person] = []
        for counter in 0..<names.count {
            persons.append(
                Person(
                    name: names[counter],
                    surname: surnames[counter],
                    phoneNumber: phoneNumbers[counter],
                    email: emails[counter]
                )
            )
        }
        
        return persons
    }
}
