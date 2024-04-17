//
//  YoutubeManager.swift
//  MusicMoodApp
//
//  Created by Katie Creech on 4/17/24.
//

import Foundation

import GameplayKit

class YouTubeManager {
    var urls: [String]
    var currentIndex = 0
    
    init(urls: [String]) {
        self.urls = urls
    }
    
    func getVideoID(from url: String) -> String? {
        if let urlComponents = URLComponents(string: url),
           let queryItems = urlComponents.queryItems {
            for item in queryItems where item.name == "v" {
                return item.value
            }
        }
        return nil
    }
    
    func getRandomVideoID() -> String? {
        
        
        guard !urls.isEmpty else { return nil }
             
             let nextURL = urls[currentIndex % urls.count] 
             currentIndex += 1
             return getVideoID(from: nextURL)
         
        
        // Shuffle the array to ensure randomness
//        let shuffledUrls = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: urls) as! [String]
//
//        if let randomURL = shuffledUrls.first {
//            return getVideoID(from: randomURL)
//        }
//        return nil
    }
  
    }



