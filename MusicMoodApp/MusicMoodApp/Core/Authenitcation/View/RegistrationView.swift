//
//  RegistrationView.swift
//  MusicMoodApp
//
//  Created by Katie Creech on 3/17/24.
//


import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        VStack{
            //image
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(width:100,height: 120)
                .padding(.vertical,32)
            VStack(spacing: 24){
                InputView(text: $fullName, title: "Full Name", placeHolder: "Enter your name")
                    .autocapitalization(.none)
                
                InputView(text: $email, title: "Email Address", placeHolder: "Name@example.com")
                
                InputView(text: $password, title: "Password", placeHolder: "Enter Your Password", isSecureFeild: true)
               // ZStack(alignment: .trailing){
                    InputView(text: $confirmPassword, title: "Confirm Passowrd", placeHolder: "Confirm Your Password", isSecureFeild: true)
                    
//                    if !password.isEmpty && !confirmPassword.isEmpty{
//                        if password == confirmPassword{
//                            Image(systemName: "checkmark.circle.fill")
//                                .imageScale(.large)
//                                .fontWeight(.bold)
//                                .foregroundColor(Color(.systemGreen))
//
//                        }else{
//                            Image(systemName: "xmark.circle.fill")
//                                .imageScale(.large)
//                                .fontWeight(.bold)
//                                .foregroundColor(Color(.systemRed))
//                        }
//                    }
//                }
            }
            
            .padding(.horizontal)
            .padding(.top, 12)
            
            
            Button{
                Task{
                    try await viewModel.createUser(withEmail: email, password: password, fullname: fullName)
                }
                
            }
        label:{
            HStack{
                Text("SIGN UP")
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            
        }
        .background(Color(.systemPurple))
//        .disabled(formIsValid)
//        .opacity(formIsValid ? 1.0 : 0.5)
        .cornerRadius(10)
        .padding(.top, 24)
            
            
            }
        Spacer()
        Button{
            dismiss()
        }label: {
            HStack(spacing: 3){
                Text("Already have an account?")
                Text("Sign in")
                    .fontWeight(.semibold)
            }
            .font(.system(size: 14))
        }
        }
}

//extension RegistrationView: AuthenticationFormProtocol{
//    var formIsValid: Bool{
//        return !email.isEmpty
//        && email.contains("@")
//        && !password.isEmpty
//        && password.count > 5
//        && confirmPassword == password
//        && !fullName.isEmpty
//    }
//}


#Preview {
    RegistrationView()
}
