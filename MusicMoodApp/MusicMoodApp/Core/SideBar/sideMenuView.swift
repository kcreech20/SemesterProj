//
//  sideMenuView.swift
//  MusicMoodApp
//
//  Created by Katie Creech on 4/15/24.
//

import SwiftUI

enum SideMenuRowType: Int, CaseIterable{
    case home = 0
    case logout
    case help
    //case profile
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .logout:
            return "Logout"
        case .help:
            return "Help"
//        case .profile:
//            return "Profile"
        }
    }
    
    var iconName: String {
           switch self {
           case .home:
               return "house"
           case .logout:
               return "arrow.right.square"
           case .help:
               return "questionmark.circle"
           }
       }
   }

struct SideMenuView: View {
    
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        HStack {
            
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                ///CHANGE COLOR HERE
                    .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    ProfileImageView()
                        .frame(height: 140)
                        .padding(.bottom, 30)
                    
                    ForEach(SideMenuRowType.allCases, id: \.self){ row in
                        RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                            selectedSideMenuTab = row.rawValue
                            presentSideMenu.toggle()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    Color.white
                )
            }
            
            
            Spacer()
        }
        .background(.clear)
    }
    
    func ProfileImageView() -> some View{
        VStack(alignment: .center){
            HStack{
                Spacer()
                Image("AppLogo")//add the app image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                        //CHANGE COLOR HERE
                            .stroke(.purple.opacity(0.5), lineWidth: 10)
                    )
                    .cornerRadius(50)
                Spacer()
            }
            
//            Text("Muhammad Abbas")//try taking from the user id
//                .font(.system(size: 18, weight: .bold))
//                .foregroundColor(.black)
//
//            Text("IOS Developer")
//                .font(.system(size: 14, weight: .semibold))
//                .foregroundColor(.black.opacity(0.5))
        }
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                    //CHANGE COLOR HERE
                        .fill(isSelected ? .purple : .white)
                        .frame(width: 5)
                    
                    ZStack{
                        Image(systemName: imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? .black : .gray)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            //CHANGE COLOR HERE
            LinearGradient(colors: [isSelected ? .purple.opacity(0.5) : .white, .white], startPoint: .leading, endPoint: .trailing)
        )
    }
}
