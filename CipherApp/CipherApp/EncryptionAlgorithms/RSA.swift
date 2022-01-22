//
//  RSA.swift
//  CipherApp
//
//  Created by Pavlentiy on 13.09.2021.
//

import Foundation

class RSA {
    // Convert each letter in the plaintext to numbers based on
    // the character using a^key mod n
    func encrypt(_ plainText: String, with publicKey: (Int, Int)) -> [Int] {
        
        let (key, n) = publicKey
        var cipherText: [Int] = []
        
        for char in plainText {
            let encodedAsciiValue = findRemainder(of: Int(char.asciiValue ?? 1), toPowerOf: key, dividedBy: n)
            cipherText.append(encodedAsciiValue)
        }
        
        return cipherText
    }
    
    func decrypt(_ cipherText: [Int], with privateKey: (Int, Int)) -> String {
        
        let (key, n) = privateKey
        var plainText = ""
        
        // Generate the plaintext based on the ciphertext and key using a^key mod n
        for encodedNumber in cipherText {
            let decodedAsciiValue = findRemainder(of: encodedNumber, toPowerOf: key, dividedBy: n)
            plainText += String(Unicode.Scalar(decodedAsciiValue) ?? " ")
        }
        
        return plainText
    }
    
    func generateKeyPair(using x: Int, and y: Int) -> (publicKey: (Int, Int), privateKey: (Int, Int), CompletionStatus) {
        
        var completionStatus = CompletionStatus.ok
        var publicKey = (0, 0)
        var privateKey = (0, 0)
        
        if !isPrime(x) || !isPrime(y) {
            completionStatus = .error(title: "Ooops", body: "Both numbers must be prime")
            return (publicKey, privateKey, completionStatus)
            
        } else if x == y {
            completionStatus = .error(title: "Ooops", body: "Numbers cannot be equal")
            return (publicKey, privateKey, completionStatus)
        }
        
        let n = x * y
        let phi = (x - 1) * (y - 1)
        
        // Choose an integer e such that e and phi(n) are coprime
        var e = Int.random(in: 1..<phi)
        
        // Use Euclid's Algorithm to verify that e and phi(n) are coprime
        var g = findGreatestCommonDivisor(for: e, and: phi)
        while g != 1 {
            e = Int.random(in: 1..<phi)
            g = findGreatestCommonDivisor(for: e, and: phi)
        }
        
        // Use Extended Euclid's Algorithm to generate the private key
        var d = findMultiplicativeInverse(for: e, and: phi)
        
        while e == d {
            ((d, _), (e, _), completionStatus) = generateKeyPair(using: x, and: y)
        }
        
        privateKey = (e, n)
        publicKey = (d, n)
        
        return (publicKey, privateKey, completionStatus)
    }
    
    enum CompletionStatus {
        case ok
        case error(title: String, body: String)
    }
}


// MARK: - Private methods
extension RSA {
    // Euclid's extended algorithm for finding the multiplicative inverse of two numbers.
    // In other words, we are looking for d such that d * e mod phi = 1
    private func findMultiplicativeInverse(for e: Int, and phi: Int) -> Int {
        
        let phiInitial = phi
        
        // values ​​from formula
        var e = e
        var phi = phi
        var y = 1
        var d = 0
        var i = -1
        
        var integerParts: [Int] = []
        
        while e % phi != 0 {
            i += 1
            integerParts.append(e / phi)
            
            let remainder = e % phi
            e = phi
            phi = remainder
        }
        
        for i in (0...i).reversed() {
            (d, y) = (y, d - y * integerParts[i])
        }
        
        if d < 0 {
            d += phiInitial
        }
        
        return d
    }
    
    // Euclid's algorithm for determining the greatest common divisor.
    private func findGreatestCommonDivisor(for x: Int, and y: Int) -> Int {
        
        if x == 0 || y == 0 {
            return max(x, y)
        } else {
            var x = x
            var y = y
            
            while x != y {
                if x > y {
                    x -= y
                } else {
                    y -= x
                }
            }
            
            return x
        }
    }
    
    private func isPrime(_ number: Int) -> Bool {
        
        if number % 2 == 0 {
            return number == 2
        } else {
            var divisor = 3
            
            while number % divisor != 0 && number > divisor {
                divisor += 2
            }
            
            return divisor == number
        }
    }
    
    private func findRemainder(of base: Int, toPowerOf exponent: Int, dividedBy modulus: Int) -> Int {
        
        guard base > 0 && exponent >= 0 && modulus > 0
            else { return -1 }

        var base = base
        var exponent = exponent
        var result = 1

        while exponent > 0 {
            if exponent % 2 == 1 {
                result = (result * base) % modulus
            }
            base = (base * base) % modulus
            exponent = exponent / 2
        }

        return result
    }
}
