//
//  CameraViewModel.swift
//  MusicMoodApp
//
//  Created by Skylar M. Purks on 4/14/24.
//

import Foundation

class CameraViewModel: ObservableObject{
    @Published var Image: Data?
    
    func selectImage(image i: Data){
        Image = i
    }
    
    func sendToModel(){
        
    }
}
