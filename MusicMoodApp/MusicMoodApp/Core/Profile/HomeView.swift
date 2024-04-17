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
    @State private var videoID: String = "-GQg25oP0S4"
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
       
        "https://www.youtube.com/watch?v=-GQg25oP0S4"
     
        
    ])
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
                if let newVideoID = youtubeManager.getRandomVideoID() {
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
    func classifyImage() {
            guard let selectedImage = selectedImage else { return }
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(selectedImage.imageOrientation.rawValue)) ?? .up
            guard let ciImage = CIImage(image: selectedImage) else { return }
            
            // Load the Core ML model
        guard let model = try? VNCoreMLModel(for: CoreMLClassifier().model) else {
                    fatalError("Failed to load Core ML model")
                }
            
            // Create a request to classify the image
            let request = VNCoreMLRequest(model: model) { request, error in
                guard let results = request.results as? [VNClassificationObservation],
                      let topResult = results.first else {
                    self.classificationLabel = "Unable to classify image."
                    return
                }
                //self.classificationLabel = "\(topResult.identifier) - \(topResult.confidence)"
                self.classificationLabel = String(format: "%@: %.2f%%", topResult.identifier, topResult.confidence * 100)
            }
            
         
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([request])
            } catch {
                self.classificationLabel = "Error: \(error.localizedDescription)"
            }
        }
    
}
