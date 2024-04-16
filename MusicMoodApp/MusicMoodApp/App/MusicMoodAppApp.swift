//
//  MusicMoodAppApp.swift
//  MusicMoodApp
//
//  Created by Katie Creech on 3/17/24.
//

import SwiftUI
import Firebase
@main
struct MusicMoodAppApp: App {
    @StateObject var viewModel = AuthViewModel()
       init(){
           FirebaseApp.configure()
       }
       
       var body: some Scene {
           WindowGroup {
               ContentView()
                   .environmentObject(viewModel)
           }
       }
   }
