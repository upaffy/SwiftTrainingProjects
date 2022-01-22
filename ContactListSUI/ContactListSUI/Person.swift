//
//  Person.swift
//  ContactListSUI
//
//  Created by Pavlentiy on 12.11.2021.
//

struct Person: Hashable {
    let name: String
    let surname: String
    let email: String
    let phoneNumber: String
    
    var fullName: String {
        "\(name) \(surname)"
    }
    
    
    static func getPersons() -> [Person] {
        let dataManager = DataManager.shared
        
        let names = dataManager.names.shuffled()
        let surnames = dataManager.surnames.shuffled()
        let emails = dataManager.emails.shuffled()
        let phoneNumbers = dataManager.phoneNumbers.shuffled()
        
        var persons: [Person] = []
        
        for counter in 0..<names.count {
            let newPerson = Person(
                name: names[counter],
                surname: surnames[counter],
                email: emails[counter],
                phoneNumber: phoneNumbers[counter]
            )
            
            persons.append(newPerson)
        }
        
        return persons
    }
}
