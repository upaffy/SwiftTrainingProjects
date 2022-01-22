//
//  ContentView.swift
//  Countdown
//
//  Created by Pavlentiy on 04.11.2021.
//

import SwiftUI

struct ContentView: View {
    let userName: String
    
    private let storageManager = StorageManager.shared
    
    @StateObject var timer = TimeCounter()
        
    var body: some View {
        VStack(spacing: 100) {
            Text("Hi, \(userName)")
                .font(.largeTitle)
                .padding(.top, 100)
            Text("\(timer.counter)")
                .font(.largeTitle)
            ButtonView(color: .red,
                       title: timer.buttonTitle,
                       action: timer.startTimer
            )
            
            Spacer()
            ButtonView(color: .blue,
                       title: "LogOut",
                       action: deleteNameFromUD
            )
        }
    }
    
    private func deleteNameFromUD() {
        print("userName:", userName, ".")
        storageManager.deleteData(for: "userName")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userName: "Pavel")
    }
}

struct ButtonView: View {
    let color: Color
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 200, height: 60)
        .background(color)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 4)
        )
    }
}
