//
//  DataManager.swift
//  ContactList
//
//  Created by Pavlentiy on 08.09.2021.
//

class DataManager {
    static let shared = DataManager()
    
    let names = [
        "Toby",
        "Hugo",
        "Jeremy",
        "Edward",
        "Bruno",
        "Nicholas",
        "Lawrence",
        "Jonah",
        "John",
        "Peter"
    ]
    
    let surnames = [
        "Ray",
        "Underwood",
        "Lawrence",
        "McBride",
        "Todd",
        "Booker",
        "Whitehead",
        "Carson",
        "Greene",
        "Miller"
    ]
    
    let phoneNumbers = [
        "155082825",
        "201548452",
        "192872491",
        "939302776",
        "662658269",
        "205064582",
        "268554279",
        "543350095",
        "540683895",
        "681204776"
    ]
    
    let emails = [
        "qqqq@gmail.com",
        "wwww@gmail.com",
        "eeee@gmail.com",
        "rrrr@gmail.com",
        "tttt@gmail.com",
        "yyyy@gmail.com",
        "uuuu@gmail.com",
        "iiii@gmail.com",
        "oooo@gmail.com",
        "pppp@gmail.com"
    ]
    
    private init() {}
}
