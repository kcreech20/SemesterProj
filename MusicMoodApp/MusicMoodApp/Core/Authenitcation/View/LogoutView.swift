//
//  LogoutView.swift
//  MusicMoodApp
//
//  Created by Katie Creech on 4/15/24.
//
import SwiftUI

struct LogoutView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var presentSideMenu: Bool
    @State private var showingLogoutAlert = true

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
                Spacer()
            }
            .padding(.top, 16)
            .padding(.horizontal)
            
            Spacer() // Push everything up

            Text("Do you want to log out?")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()

            Button(action: {
                showingLogoutAlert = true
            }) {
                Text("Logout")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer() // Push everything up
        }
        .alert(isPresented: $showingLogoutAlert) {
            Alert(
                title: Text("Confirm Logout"),
                message: Text("Are you sure you want to log out?"),
                primaryButton: .destructive(Text("Logout")) {
                    authViewModel.signOut()
                    presentSideMenu = false
                },
                secondaryButton: .cancel()
            )
        }
        .onAppear {
            showingLogoutAlert = true
        }
    }
}

