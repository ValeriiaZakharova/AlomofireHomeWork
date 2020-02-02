//
//  WebViewController.swift
//  homeWorkAlamofire
//
//  Created by Valeriia Zakharova on 25.01.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webWiew: WKWebView!
    
    var urlData: NewsArticleModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webWiew.navigationDelegate = self
        
        guard let urlFirst = urlData, let urlCorrrect = urlFirst.url else {
            print("Error")
            return
        }
        
        let url = URL(string: urlCorrrect)
        
        if let urlLast = url {
            let urlRequest = URLRequest(url: urlLast)
            webWiew.load(urlRequest)
        }
            
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        debugPrint("didFailProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        decisionHandler(.allow)
    }
}
