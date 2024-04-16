//
//  HelpView.swift
//  MusicMoodApp
//
//  Created by Katie Creech on 4/15/24.
//

import SwiftUI

struct HelpView: View {
    @Binding var presentSideMenu: Bool
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack{
                        Button{
                            presentSideMenu.toggle()
                        } label: {
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(.purple)
                                .font(.title)
                        }
                        .padding(.leading, 16)
                        Spacer()
                            
                    }
                    Text("Help")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 16)

                    Text("""
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                        """)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                }
                .padding()
            }
            .navigationTitle("Help")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(presentSideMenu: .constant(false))
    }
}
