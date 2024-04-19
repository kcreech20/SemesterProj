//
//  HomeView.swift
//  MusicMoodApp
//
//  Created by Katie Creech on 3/17/24.

import SwiftUI
import WebKit
import CoreML
import Vision
import AVKit

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var presentSideMenu: Bool
    @State private var videoID: String = ""
    @State private var showImagePicker: Bool = false
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?// Default video ID
    @State private var classificationLabel: String = ""
    @State private var convertedUIImage: UIImage?
    @State private var showConvertedUIImage: Bool = false
    var imageClassifier: CoreMLClassifier
    
    init(imageClassifier: CoreMLClassifier, presentSideMenu: Binding<Bool>) {
        self.imageClassifier = imageClassifier
        self._presentSideMenu = presentSideMenu // Note the underscore here
        // self.printModelPreprocessingDetails() if needed
    }
    
    private let youtubeManager = YouTubeManager(urls: [
        
        ""
        
        
    ])
    @available(iOS 17.0, *)
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
                .padding(.leading, 16)
                Spacer()
            }
            Spacer()
            YouTubeView(videoID: videoID)
                .frame(height: 300)
            Spacer()
            Button("Change Video") {
                if let newVideoID = youtubeManager.getNextVideoID() {
                    videoID = newVideoID
                }
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            
            
            
            HStack {
                Button("Library") {
                
                    self.imagePickerSourceType = .photoLibrary
                    self.showImagePicker = true
                }
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("Photo") {
                    self.imagePickerSourceType = .camera
                   
                        self.showImagePicker = true
                    
                }
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            Text(classificationLabel)
                .padding()
                .foregroundColor(.purple)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, sourceType: imagePickerSourceType)
        }
        .onChange(of: selectedImage) { oldImage, newImage in
            if oldImage != newImage {
                classifyImage()
            }
        }
        
        .background(Color.white)
        .preferredColorScheme(.light)
        
    }
    // Define a function to classify an image using a Core ML model.
    func classifyImage() {
        // Check if an image is selected and can be converted to a CIImage, and if the Core ML model can be loaded.
        guard let selectedImage = selectedImage,
              let ciImage = CIImage(image: selectedImage),
              let model = try? VNCoreMLModel(for: CoreMLClassifier().model) else {
            // If the image or model isn't available, update the UI with an error message and exit the function.
            self.classificationLabel = "Unable to classify image or load model."
            return
        }
        
        // Convert the image orientation from UIImageOrientation to CGImagePropertyOrientation.
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(selectedImage.imageOrientation.rawValue)) ?? .up
        
        // Create a Core ML request with the loaded model and handle the results asynchronously.
        let request = VNCoreMLRequest(model: model) { request, error in
            // Process the result on the main thread because it involves UI updates.
            DispatchQueue.main.async {
                // Cast the result to an array of VNClassificationObservation and get the most confident result.
                if let results = request.results as? [VNClassificationObservation],
                   let topResult = results.first {
                    // Handle the top classification result.
                    self.handleClassificationResult(topResult)
                } else {
                    // If no results are obtained, update the UI with an error message.
                    self.classificationLabel = "Unable to classify image."
                }
            }
        }

        // Create a handler to perform the Core ML request using the selected image and its orientation.
        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
        do {
            // Perform the request with the image handler.
            try handler.perform([request])
        } catch {
            // Handle any errors in the request execution by updating the UI with an error message.
            DispatchQueue.main.async {
                self.classificationLabel = "Error: \(error.localizedDescription)"
            }
        }
    }

    // Define a function to handle the classification result by updating the UI and initiating a fetch for related song URLs.
    private func handleClassificationResult(_ result: VNClassificationObservation) {
        // Update the UI with the classification result and its confidence level formatted as a percentage.
        self.classificationLabel = String(format: "%@: %.2f%%", result.identifier, result.confidence * 100)
        
        // Fetch song URLs that correspond to the identified emotion from the classification.
        fetchSongURLsForEmotion(result.identifier)
    }

    
    private func fetchSongURLsForEmotion(_ emotion: String) {
        FirebaseManager.shared.fetchURLForEmotion(emotion) { fetchedURLs in
            DispatchQueue.main.async {
                print("Fetched URLs: \(String(describing: fetchedURLs))")
                if let fetchedURLs = fetchedURLs, !fetchedURLs.isEmpty {
                    self.youtubeManager.updateURLs(newURLs: fetchedURLs)
                    print("Updated YouTubeManager URLs: \(self.youtubeManager.urls)")
                    if let newVideoID = self.youtubeManager.getNextVideoID() {
                        self.videoID = newVideoID
                        print("New video ID: \(newVideoID)")
                    }
                } else {
                    // Handle the case where no URLs were fetched or array is empty
                    self.classificationLabel = "No videos available for this emotion."
                    print("No videos available for this emotion.")
                }
            }
        }
    }


}

//    func classifyImage() {
//        guard let selectedImage = selectedImage else { return }
//        let orientation = CGImagePropertyOrientation(rawValue: UInt32(selectedImage.imageOrientation.rawValue)) ?? .up
//        guard let ciImage = CIImage(image: selectedImage) else { return }
//        
//        // Load the Core ML model
//        guard let model = try? VNCoreMLModel(for: CoreMLClassifier().model) else {
//            fatalError("Failed to load Core ML model")
//        }
//        
//        // Create a request to classify the image
//        let request = VNCoreMLRequest(model: model) { request, error in
//            guard let results = request.results as? [VNClassificationObservation],
//                  let topResult = results.first else {
//                self.classificationLabel = "Unable to classify image."
//                return
//            }
//            //self.classificationLabel = "\(topResult.identifier) - \(topResult.confidence)"
//            self.classificationLabel = String(format: "%@: %.2f%%", topResult.identifier, topResult.confidence * 100)
//        }
//        
//        
//        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
//        do {
//            try handler.perform([request])
//        } catch {
//            self.classificationLabel = "Error: \(error.localizedDescription)"
//        }
//        let classifiedEmotion = topResult.identifier
//                    FirebaseManager.shared.fetchURLForEmotion(classifiedEmotion) { fetchedURLs in
//                        DispatchQueue.main.async {
//                            if let fetchedURLs = fetchedURLs, !fetchedURLs.isEmpty {
//                                self.youtubeManager.updateURLs(newURLs: fetchedURLs)
//                                if let newVideoID = self.youtubeManager.getNextVideoID() {
//                                    self.videoID = newVideoID
//                                    print("we got this far")
//                                }
//                            } else {
//                                // Handle the case where no URLs were fetched or array is empty
//                                self.classificationLabel = "No videos available for this emotion."
//                            }
//                        }
//                    }
//    }
//}
            
//            // 'topResult.identifier' gives you the classification result
//            // This is where you fetch the URLs from Firebase
//            let classifiedEmotion = topResult.identifier
//            FirebaseManager.shared.fetchURLForEmotion(classifiedEmotion) { fetchedURLs in
//                DispatchQueue.main.async {
//                    if let fetchedURLs = fetchedURLs, !fetchedURLs.isEmpty {
//                        self.youtubeManager.updateURLs(newURLs: fetchedURLs)
//                        if let newVideoID = self.youtubeManager.getNextVideoID() {
//                            self.videoID = newVideoID
//                            print("we got this far")
//                        }
//                    } else {
//                        // Handle the case where no URLs were fetched or array is empty
//                        self.classificationLabel = "No videos available for this emotion."
//                    }
//                }
//            }
            
            
//            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
//            do {
//                try handler.perform([request])
//            } catch {
//                DispatchQueue.main.async {
//                    self.classificationLabel = "Error: \(error.localizedDescription)"
//                }
//            }
//        }
//    }
//}

    


