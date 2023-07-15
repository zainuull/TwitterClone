//
//  LoginView.swift
//  Twitter
//
//  Created by Zainul on 27/06/23.
//

import SwiftUI

struct LoginView: View {
    
    @State var email : String = ""
    @State var password : String = ""
    
    //App Storage
    @AppStorage("email") var userEmail : String?
    @AppStorage("password") var userPassword : String?
    @AppStorage("signed_in") var isSignedIn : Bool = false
    
    
    var body: some View {
        VStack(spacing: 30){
            Logo
            
            emailInput
            passwordInput
            
            orText
            
            signInWith(name: "Google", image: "google")
            signInWith(name: "Apple", image: "apple")
            
            buttonSignIn
            
            Text("Forget Password")
                .font(.headline)
                .fontWeight(.bold)
            
            HStack {
                Text("Don't hane an account ?")
                Text("Sign Uo")
                    .foregroundColor(.blue)
            }.foregroundColor(.gray).font(.caption)

        }
        .padding(20)
        .padding(.vertical,30)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(15)

    }
}

// MARK: COMPONENTS
extension LoginView {
    var Logo : some View {
        Image("twitter")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 80)
    }
    
    var orText : some View {
        HStack {
            Rectangle()
                .frame(height: 1)
            
            Text("Or")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            Rectangle()
                .frame(height: 1)
        }
    }
    
    var buttonSignIn : some View {
        Button {
            login()
        } label: {
            Text("Sign In")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color("primary"))
                .cornerRadius(20)
        }

    }
    
    var emailInput : some View {
        TextField("Phone or Email", text: $email)
            .font(.headline)
            .padding(.horizontal)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
            )
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
    }
    
    var passwordInput : some View {
        SecureField("Password", text: $password)
            .font(.headline)
            .padding(.horizontal)
            .frame(height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
            )
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
    }
}

//MARK: FUNCTIONS
extension LoginView {
    func login() {
        userEmail = email
        userPassword = password
        withAnimation(.spring()) {
            isSignedIn = true
        }
    }
}


struct signInWith : View {
    
    let name : String
    let image : String
    
    var body : some View {
        HStack(spacing: 20){
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            Text("Sign in With \(name)")
                .font(.headline)
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


