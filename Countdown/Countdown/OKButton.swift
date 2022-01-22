//
//  OKButton.swift
//  Countdown
//
//  Created by Pavlentiy on 05.11.2021.
//

import SwiftUI

struct OKButton: View {
    private let storageManager = StorageManager.shared
    
    @Binding var enteredCharacters: String
    @State private var alertPresented = false
    
    var body: some View {
        Button {
            checkEnteredData {
                storageManager.save(data: enteredCharacters, for: "userName")
            }
        } label: {
            HStack {
                Image(systemName: "checkmark.circle")
                Text("OK")
            }
        }
        .disabled(enteredCharacters.count < 3)
        .alert("Wrong format", isPresented: $alertPresented) {
            Button(action: clearInput) { Text("OK") }
        } message: {
            Text("The entered name is incorrect\n Try to use another")
        }
    }
    
    private func checkEnteredData(completion: () -> Void) {
        if Double(enteredCharacters) != nil {
            alertPresented = true
        }
        completion()
    }
    
    private func clearInput() {
        enteredCharacters = ""
    }
}


struct OKButton_Previews: PreviewProvider {
    static var previews: some View {
        OKButton(enteredCharacters: .constant("111"))
    }
}
