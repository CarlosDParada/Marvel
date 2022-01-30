//
//  ImageRequest.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//

import Foundation
import UIKit

enum ImageRequestError: Error {
    case decodeFailed
}

final class ImageRequest: NetworkRequest {
    
    static let shared = ImageRequest()
    
    //    init(url: URL) {
    //        self.url = url
    //    }
    
    private var cachedImages: [String: UIImage]
    private var imagesDownloadTasks: [String: URLSessionDataTask]
    
    private init() {
        cachedImages = [:]
        imagesDownloadTasks = [:]
    }
    
    func decode(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw ImageRequestError.decodeFailed
        }
        return image
    }
    
    var imageUrlString: String?
    var url: URL?
    let imageCache = NSCache<NSString, UIImage>()
    
    // A serial queue to be able to write the non-thread-safe dictionary
    let serialQueueForImages = DispatchQueue(label: "images.queue", attributes: .concurrent)
    let serialQueueForDataTasks = DispatchQueue(label: "dataTasks.queue", attributes: .concurrent)
    
    
    func load(with imageUrlString: String?, completion: @escaping (Result<UIImage, Error>) -> Void) {

        guard let imageUrlString = imageUrlString else {
            completion(.success(UIImage.init()))
            return
        }

        if let image = getCachedImageFrom(urlString: imageUrlString) {
            completion(.success(image))
        } else {

            guard let url = URL(string: imageUrlString) else {
                completion(.success(UIImage.init()))
                return
            }

            if let _ = getDataTaskFrom(urlString: imageUrlString) {
                return
            }
            self.url = url
            
            self.load(completion: completion)
        }
    }
    func load(imageUrlString: String?, inViewImage: UIImageView) {
        
        guard let imageUrlString = imageUrlString else {
            inViewImage.image = UIImage.init()
            return
        }

        if let image = getCachedImageFrom(urlString: imageUrlString) {
            inViewImage.image = image
        } else {

            guard let url = URL(string: imageUrlString) else {
                inViewImage.image = UIImage.init()
                return
            }
            if let _ = getDataTaskFrom(urlString: imageUrlString) {
                return
            }
            self.url = url
            
            self.load { response in
                if let image = try? response.get() {
                    inViewImage.image = image
                }
            }
        }
    }
    
    func load(completion: @escaping (Result<UIImage, Error>) -> Void) {
        load(url: url!) { result in
            
            if let image = try? result.get() {
                self.cachedImages[self.url?.absoluteString ?? ""] = image
                self.imagesDownloadTasks.removeValue(forKey: self.url?.absoluteString ?? "")
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            }else{
                print(">> Error Parse Image \(self.url?.absoluteString ?? "")")
            }
        }
    }
    
    private func getCachedImageFrom(urlString: String) -> UIImage? {
        // Reading from the dictionary should happen in the thread-safe manner.
        serialQueueForImages.sync {
            return cachedImages[urlString]
        }
    }
    
    private func getDataTaskFrom(urlString: String) -> URLSessionTask? {
        
        // Reading from the dictionary should happen in the thread-safe manner.
        serialQueueForDataTasks.sync {
            return imagesDownloadTasks[urlString]
        }
    }
    
}
