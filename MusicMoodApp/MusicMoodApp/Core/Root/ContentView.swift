//
//  ContentView.swift
//  MusicMoodApp
//
//  Created by Katie Creech on 3/17/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group{
            if  viewModel.userSession != nil{
                MainTabbedView()
                
            }
            else{
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthViewModel())
        
    }
}



