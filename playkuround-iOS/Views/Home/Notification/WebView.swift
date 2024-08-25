//
//  WebView.swift
//  playkuround-iOS
//
//  Created by Hoeun Lee on 8/25/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webView.load(request)
    }
}
