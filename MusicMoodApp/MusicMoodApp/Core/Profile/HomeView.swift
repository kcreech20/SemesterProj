//
//  HomeView.swift
//  MusicMoodApp
//
//  Created by Katie Creech on 3/17/24.

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var presentSideMenu: Bool
    @State private var showCamera = false  

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentSideMenu.toggle()
                }) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.purple)
                        .font(.title)
                }
                .padding(.leading, 16)
                Spacer()
            }

            Spacer()

          
            Button(action: {
                self.showCamera = true
            }) {
                HStack {
                    Spacer()
                    Text("Take A Photo")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color.purple)
                .cornerRadius(10)
            }
            .padding(.bottom, 30)
            .sheet(isPresented: $showCamera) {
                        CameraView(isPresented: $showCamera)
                            .environmentObject(CameraViewModel())

            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(presentSideMenu: .constant(false))
            .environmentObject(AuthViewModel())
    }
}
