//
//  HomeView.swift
//  MusicMoodApp
//
//  Created by Vestibular Lab on 3/17/24.

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack {
            //Text("Hello, World!")
            NavigationLink {
                CameraView()
            } label:{
                HStack(alignment: .center, content: {
                    Text("Take A Photo")
                        .font(.system(size: 25))
                        //.Color.blue
                })}

            Spacer() // Adds space between the text and the button

            Button(action: {
                viewModel.signOut()
            }) {
                HStack {
                    Text("SIGN OUT")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right.circle.fill")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                .background(Color.red)
                .cornerRadius(24)
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel()) // Make sure to provide a mock AuthViewModel or the actual one you use in your app
    }
}
