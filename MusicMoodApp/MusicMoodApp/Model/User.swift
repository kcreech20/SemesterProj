//
//  User.swift
//  MusicMoodApp
//
//  Created by Vestibular Lab on 3/17/24.
//

import Foundation
struct User: Identifiable, Codable{
    let id: String
    let fullname: String
    let email: String
    
    var intials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    
    }
extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Kobe Bryant", email: "Testing@gmail.com")
}
