//
//  SerialListViewModel.swift
//  SerialRequestList
//
//  Created by 1778948 on 20/09/21.
//

import Foundation

struct URLItem {
    var index: Int
    var url: String
    var imageData: Data
    var status: String
}

class SerialListViewModel {
    
    var urls = [
        "apple.com",
        "spacex.com",
        "dapi.co",
        "facebook.com",
        "microsoft.com",
        "amazon.com",
        "boomsupersonic.com",
        "twitter.com"
    ]
    
    var results: [URLItem] = []
    let downloadService = DownloadService()
    
    var urlMetadataLoaded: [URLItem] = [] {
        didSet {
            self.updateTable?()
        }
    }
    
    var defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var downloadTask: URLSessionDownloadTask?
    
    var updateTable: (()->())?
    
    func startURLRequests() {
        let semaphore = DispatchSemaphore(value: 0)
        for i in 0..<self.urls.count {
            guard let url = URL(string: "https://" + self.urls[i]) else {
                return
            }
            self.defaultSession.dataTask(with: url) { data, response, error in
                let response = response as? HTTPURLResponse
                var item = URLItem(index: i, url: self.urls[i], imageData: Data(), status: "")
                if error != nil {
                    print(response?.statusCode ?? "")
                    item.status = String("\(response?.statusCode)")
                } else {
                    item.status = String("\(data?.description)")
                    print(data?.description ?? "", response?.statusCode ?? "")
                    self.defaultSession.dataTask(with: url .appendingPathComponent("/favicon.ico")) { data, response, error in
                        item.imageData = data ?? Data()
                    }
                }
                DispatchQueue.main.async {
                    self.updateTable?()
                }
                semaphore.signal()
//                guard let faviconURL = URL(string: "https://" + self.urls[i] + "/favicon.ico") else { return }
                self.results.append(item)
            }.resume()
            semaphore.wait()
        }
    }
}
