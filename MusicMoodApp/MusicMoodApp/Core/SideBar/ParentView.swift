//
//  ParentView.swift
//  MusicMoodApp
//
//  Created by Katie Creech on 4/15/24.
//


import SwiftUI

struct MainTabbedView: View {
    
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        ZStack{
            
            TabView(selection: $selectedSideMenuTab) {
                HomeView(presentSideMenu: $presentSideMenu)
                    .tag(0)
                LogoutView(presentSideMenu: $presentSideMenu)
                    .tag(1)
                HelpView(presentSideMenu: $presentSideMenu)
                    .tag(2)
            }
            
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}

