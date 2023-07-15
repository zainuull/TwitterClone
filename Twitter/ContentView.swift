//
//  ContentView.swift
//  Twitter
//
//  Created by Zainul on 27/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("signed_in") var isSignedIn : Bool = false
    
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.3)
            .ignoresSafeArea()
            
            
            if isSignedIn {
                ProfileView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .top),
                        removal: .move(edge: .bottom)))
            } else {
                RegistrationView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom),
                        removal: .move(edge: .top)))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
