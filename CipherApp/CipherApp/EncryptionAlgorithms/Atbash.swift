//
//  Atbach.swift
//  CipherApp
//
//  Created by Павел Ткачев on 16.09.2021.
//

class Atbash {
    
    let alphabet = ["A", "a", "B", "b", "C", "c", "D", "d", "E", "e", "F", "f",
                    "G", "g", "H", "h", "I", "i", "J", "j", "K", "k", "L", "l",
                    "M", "m", " ", "N", "n", "O", "o", "P", "p", "Q", "q", "R",
                    "r", "S", "s", "T", "t", "U", "u", "V", "v", "W", "w", "X",
                    "x", "Y", "y", "Z", "z"]
    
    func encryption(message: String) -> String {
        var cipherText = ""
        var reverseAlphabet: [String]  = []
        for letter in alphabet.reversed() {
            reverseAlphabet.append(letter)
        }
        for charMessage in message {
            var counter = 0
            for letter in alphabet {
                if String(charMessage) == letter {
                    cipherText.append(reverseAlphabet[counter])
                    break
                }
                counter += 1
            }
            if counter == alphabet.count {
                cipherText.append(charMessage)
            }
        }
        return cipherText
    }
    
    func decryption(cipherText: String) -> String {
        var decipherText = ""
        var reverseAlphabet: [String]  = []
        for letter in alphabet.reversed() {
            reverseAlphabet.append(letter)
        }
        for charCipherText in cipherText {
            var counter = 0
            for letter in reverseAlphabet {
                if String(charCipherText) == letter {
                    decipherText.append(alphabet[counter])
                    break
                }
                counter += 1
            }
            if counter == alphabet.count {
                decipherText.append(charCipherText)
            }
        }
        return decipherText
    }
}
