//
//  YoutubeView.swift
//  MusicMoodApp
//
//  Created by Katie Creech on 4/17/24.
//


import SwiftUI
import WebKit


struct YouTubeView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        // Create a WKWebViewConfiguration object
        let configuration = WKWebViewConfiguration()
        
        // Enable playback features
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
    
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
      
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        
        // Create a URLRequest for the URL
        let request = URLRequest(url: url)
        
  
        uiView.load(request)
    }
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//           // Define the embed HTML with the correct videoID inserted
//           let embedHTML = """
//           <html>
//           <body style="margin: 0;">
//           <iframe width="100%" height="100%" src="https://www.youtube.com/embed/\(videoID)" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
//           </body>
//           </html>
//           """
//
//           // Load the HTML string into the WKWebView
//           uiView.loadHTMLString(embedHTML, baseURL: nil)
//       }
}


