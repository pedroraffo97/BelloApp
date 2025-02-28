//
//  YoutubeVideoView.swift
//  BelloApp
//
//  Created by Pedro Raffo Leon on 28.11.23.
//

import Foundation

import SwiftUI

import WebKit

struct YoutubeVideoView: UIViewRepresentable {
    
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: "https://www.youtube.com/\(videoID)") else {return}
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: YoutubeVideoView
        
        init(_ parent: YoutubeVideoView) {
            self.parent = parent
        }
    }
    
}


struct TrialView: View {
    
    var body: some View {
        YoutubeVideoView(videoID: "watch?v=kT5OXi1PAfA")
            .frame(width: 300, height: 200)
    }
}

struct TrialView_Preview: PreviewProvider{
    static var previews: some View {
        TrialView()
    }
}
