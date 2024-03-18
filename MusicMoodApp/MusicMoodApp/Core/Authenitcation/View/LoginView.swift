//
//  LoginView.swift
//  MusicMoodApp
//
//  Created by Vestibular Lab on 3/17/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        NavigationStack{
            VStack{
                //image
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:100,height: 120)
                    .padding(.vertical,32)
                
                //form feilds
                VStack(spacing: 24){
                    InputView(text: $email, title: "Email Address", placeHolder: "Name@example.com")
                        .autocapitalization(.none)
                    InputView(text: $password, title: "Password", placeHolder: "Enter Your Password")
                }
                .padding(.horizontal)
                .padding(.top, 12)
                // sign in button
                
                Button{
                    Task{
                       try await viewModel.signIn(withEmail: email, password: password)
                    }
                    
                }
            label:{
                HStack{
                    Text("SIGN IN")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                
            }
            .background(Color(.systemMint))
//            .disabled(formIsValid)
//            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 24)
                
                
                
                
                //sign up button
                Spacer()
                
                NavigationLink {
                    RegistrationView()
                } label:{
                    HStack(spacing: 3){
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

//extension LoginView: AuthenticationFormProtocol{
//    var formIsValid: Bool{
//        return !email.isEmpty
//        && email.contains("@")
//        && !password.isEmpty
//        && password.count > 5
//    }
//}

#Preview {
    LoginView()
}
