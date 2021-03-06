//
//  Downloader.swift
//  RottenTomatoesSwift
//
//  Created by Jeffrey Bergier on 9/12/15.
//  Copyright © 2015 MobileBridge. All rights reserved.
//

import Foundation

protocol DownloaderDelegate: class {
    func downloadFinishedForURL(finishedURL: NSURL)
}

class Downloader {
    
    weak var delegate: DownloaderDelegate?
    
    private let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    private var downloaded = [NSURL : NSData]()
    
    func beginDownloadingURL(downloadURL: NSURL) {
        self.session.dataTaskWithRequest(NSURLRequest(URL: downloadURL)) { (downloadedData, response, error) in
            guard let downloadedData = downloadedData else {
                NSLog("Downloader: Downloaded Data was NIL for URL: \(downloadURL)")
                return
            }
            guard let response = response as? NSHTTPURLResponse else {
                NSLog("Downloader: Response was not an HTTP Response for URL: \(downloadURL)")
                return
            }
            
            switch response.statusCode {
            case 200:
                self.downloaded[downloadURL] = downloadedData
                self.delegate?.downloadFinishedForURL(downloadURL)
            default:
                NSLog("Downloader: Received Response Code: \(response.statusCode) for URL: \(downloadURL)")
            }
        }.resume()
    }
    
    func dataForURL(requestURL: NSURL) -> NSData? {
        return self.downloaded[requestURL]
    }
}
