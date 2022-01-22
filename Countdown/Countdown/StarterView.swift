//
//  StarterView.swift
//  Countdown
//
//  Created by Pavlentiy on 04.11.2021.
//

import SwiftUI

struct StarterView: View {
    @AppStorage("userName") var userName = ""
    
    var body: some View {
        Group {
            if userName != "" {
                ContentView(userName: userName)
            } else {
                RegisterView()
            }
        }
    }
}

struct StarterView_Previews: PreviewProvider {
    static var previews: some View {
        StarterView()
    }
}
