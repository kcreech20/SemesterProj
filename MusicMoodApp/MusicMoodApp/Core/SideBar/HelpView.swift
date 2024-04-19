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
                
                Text("Help")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading, 16)
                
                Group {
                    Text("How the App Works:")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2)
                    
                    Text("Welcome to our emotion-based music player! Our app uses advanced machine learning to detect your mood by analyzing your facial expression. Here's a quick guide to get you started:")
                    
                    Text("Capture or Upload a Photo:")
                        .fontWeight(.bold)
                    Text("Begin by taking a photo of yourself using the in-app camera or uploading an image from your gallery.")
                    
                    Text("Emotion Analysis:")
                        .fontWeight(.bold)
                    Text("Once the photo is captured or uploaded, our app utilizes a CoreML model to analyze your facial expression and determine your current emotion.")
                    
                    Text("Music to Match Your Mood:")
                        .fontWeight(.bold)
                    Text("Based on the emotion detected, the app will then retrieve a YouTube URL from our curated emotion-specific playlists. For instance, if you're feeling happy, you'll get a song that amplifies your happiness!")
                    
                    Text("Enjoy the Music:")
                        .fontWeight(.bold)
                    Text("Play the suggested song right within the app, and let the music resonate with your emotions.")
                }
                .padding([.leading, .trailing], 16)
                
                Group {
                    Text("Important Warning:")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2)
                    
                    Text("Make sure your face is clearly visible in the photo.")
                    Text("Ensure good lighting conditions.")
                    Text("Only human facial expressions can be classified; the app may not work with inanimate objects or animals.")
                }
                .fontWeight(.semibold)
                .padding([.leading, .trailing], 16)
                
                Spacer() 
            }
        }
        .navigationTitle("Help")
        .navigationBarTitleDisplayMode(.inline)
    }
}




