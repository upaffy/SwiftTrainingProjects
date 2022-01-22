//
//  RegisterView.swift
//  Countdown
//
//  Created by Pavlentiy on 04.11.2021.
//

import SwiftUI

struct RegisterView: View {
    @State private var userName = ""
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                TextField("Enter your name", text: $userName)
                    .offset(x: 10)
                    .multilineTextAlignment(.center)
                CharacterCounter(enteredCharacters: $userName)
            }
            .padding()
            
            OKButton(enteredCharacters: $userName)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

struct CharacterCounter: View {
    @Binding var enteredCharacters: String
    
    var body: some View {
        let color = enteredCharacters.count < 3 ? Color.red : Color.green
        
        Text("\(enteredCharacters.count)")
            .foregroundColor(color)
    }
}
