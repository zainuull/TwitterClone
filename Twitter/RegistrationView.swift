//
//  RegistrationView.swift
//  Twitter
//
//  Created by Zainul on 27/06/23.
//

import SwiftUI

struct RegistrationView: View {
    

    @State var onBoardingState : Int = 0
    let transition : AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))

    
    var body: some View {
        ZStack{
            switch onBoardingState {
            case 0:
                Registraion(onBoardingState: $onBoardingState)
                    .transition(transition)
            case 1:
                LoginView()
                    .transition(transition)
            default:
                Rectangle()
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

struct Registraion : View {
    
    @State var name : String = ""
    @State var email : String = ""
    @State var password : String = ""
    @State var isCheck : Bool = false
    @Binding var onBoardingState : Int
    @State var showAlert : Bool = false
    @State var AlertTitle : String = ""
    
    //App Storage
    @AppStorage("name") var userName : String?
    @AppStorage("email") var userEmail : String?
    @AppStorage("password") var userPassword : String?
    
    var body : some View {
        VStack(alignment: .leading, spacing: 30){
            nameTwitter
            
            //Form
            nameInput
            emailInput
            passwordInput
            
            
            agreeText
            
            buttonSignUp
        }
        .padding(20)
        .padding(.vertical,30)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding(15)
        .alert(isPresented: $showAlert) {
            return Alert(title: Text(AlertTitle))
        }
    }
}


// MARK: COMPONENTS
extension Registraion {
    var nameTwitter : some View {
        Text("Join Twitter today.")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    var agreeText : some View {
        HStack {
            Rectangle()
                .stroke()
                .overlay(
                    Image(systemName: isCheck ? "checkmark" : "")
                        .foregroundColor(.blue)
                        
                )
                .frame(width: 15, height: 15)
                .offset(y:-10)
                .onTapGesture {
                    isCheck.toggle()
            }
            
            Text("Personalize Twitter based on where you've been Twitter content on the web.")
        }
        .font(.caption)
    }
    
    var buttonSignUp : some View {
        Button {
            SignUp()
        } label: {
            Text("Sign Up")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color("primary"))
                .cornerRadius(20)
            
        }
    }
    
    var nameInput : some View {
        TextField("Full Name", text: $name)
            .font(.headline)
            .padding(.horizontal)
            .frame(height: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
            )
            .frame(maxWidth: .infinity)
            .cornerRadius(10)
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


// MARK: FUNCTIONS
extension Registraion {
    func SignUp() {
        userName = name
        userEmail = email
        userPassword = password
        
        if name.count >= 3 && email.count >= 5 && password.count >= 8 && isCheck == true {
            withAnimation(.spring()) {
                onBoardingState += 1
            }
        } else {
            getAlert(title: "You must fill this form to next section 😜")
        }
    }
    
    func getAlert(title : String) {
        AlertTitle = title
        showAlert.toggle()
    }
}

