//
//  FirebasePulling.swift
//  MusicMoodApp
//
//  Created by Vestibular Lab on 4/18/24.
//

import Foundation
import Firebase

class FirebaseManager {
    static let shared = FirebaseManager() // Singleton instance

    private init() {} // Private initializer for singleton
    
    func fetchURLForEmotion(_ emotion: String, completion: @escaping ([String]?) -> Void) {
        let db = Firestore.firestore()
        db.collection("Songs").document("mi00XubzwMW13gESwvQ2").collection(emotion).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil)
            } else {
                var urls = [String]()
                // Here we are assuming all documents inside the emotion subcollection have the same structure.
                for document in querySnapshot!.documents {
                    if let songUrls = document.data()["Songs"] as? [String] {
                        urls.append(contentsOf: songUrls)
                    }
                }
                if urls.isEmpty {
                    print("No songs available for the emotion \(emotion).")
                    completion(nil)
                } else {
                    completion(urls)
                }
            }
        }
    }


}


