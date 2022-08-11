//
//  DownloadService.swift
//  SerialRequestList
//
//  Created by 1778948 on 22/09/21.
//

import Foundation

class Download {
    var isDownloaded = false
    var task: URLSessionDownloadTask?
    var urlItem: URLItem
    
    init(urlItem: URLItem) {
      self.urlItem = urlItem
    }
}

class DownloadService {
    
    var downloadsSession = URLSession(configuration: .default)
    
    var activeDownloads: [URL: Download] = [:]
    
    func startDownload(_ url: URL) {
//      let download = Download(urlItem: urlItem)
        let task = downloadsSession.downloadTask(with: url) {_,_,_ in
            
        }
        task.resume()
    }
}
