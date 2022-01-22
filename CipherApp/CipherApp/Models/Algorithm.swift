//
//  Algorithm.swift
//  CipherApp
//
//  Created by Pavlentiy on 18.09.2021.
//

struct Algorithm {
    let name: String
    let algorithmClass: Any
    
    static func getAlgorithms() -> [Algorithm] {
        [Algorithm(name: "RSA", algorithmClass: RSA()),
         Algorithm(name: "Atbash", algorithmClass: Atbash()),
         Algorithm(name: "Vigenere", algorithmClass: Vigenere())]
    }
}
