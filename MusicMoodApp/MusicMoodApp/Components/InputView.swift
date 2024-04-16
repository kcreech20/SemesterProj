//
//  InputView.swift
//  MusicMoodApp
//
//  Created by Katie Creech on 3/17/24.
//


import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeHolder: String
    var isSecureFeild = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecureFeild{
                SecureField(placeHolder, text:$text)
                    .font(.system(size: 14))
            }
            else{
                TextField(placeHolder, text: $text)
                    .font(.system(size: 14))
            }
            
                Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeHolder: "name@example.com")
}
