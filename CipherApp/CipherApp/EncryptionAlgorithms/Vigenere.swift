//
//  Vigenere.swift
//
//
//  Created by Никита Гуляев on 15.09.2021.
//

class Vigenere {
    
    let asciiTableCount = 127
    var keyFoAsciiTable = 10
    
    func encryption(message: String) -> String {
        var encryption = ""
        
        for char in message {
            let asciiCode = (Int((char.asciiValue ?? 0 )) + keyFoAsciiTable) % asciiTableCount
            encryption.append(Character(UnicodeScalar(asciiCode) ?? " "))
        }
        return encryption
    }
    
    
    func decrypt(message: String) -> String {
        var decryption = ""
        
        for char in message {
            let asciiCode = (Int((char.asciiValue ?? 0 ) - UInt8(keyFoAsciiTable)) + asciiTableCount) % asciiTableCount
            decryption.append(Character(UnicodeScalar(asciiCode) ?? " "))
        }
        return decryption
    }
}
