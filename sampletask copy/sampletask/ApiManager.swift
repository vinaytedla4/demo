//
//  ApiManager.swift
//  sampletask
//
//  Created by Vinay on 18/02/24.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private var imageCache = NSCache<NSString, UIImage>()

    private init() {}

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            self?.imageCache.setObject(image, forKey: urlString as NSString)
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
    
    
    
    
    func fetchingAPI(pageno : Int, completion: @escaping (ApiResponse) -> Void) {
        
        
        let url : String = "https://reqres.in/api/users?page=\(pageno)"
        if let url = URL(string: url) {
            let session = URLSession.shared
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 3){
                let dataTask = session.dataTask(with: url) { data, response, error in
                    if let data = data, error == nil {
                        // Print the JSON response
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Received JSON: \(jsonString)")
                        }
                        
                        do {
                            

                            let parsingData = try JSONDecoder().decode(ApiResponse.self, from: data)
                            completion(parsingData)

                            
                        } catch {
                            print("Parsing error: \(error)")
                            
                        }
                    } else {
                        print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                        
                    }
                }
                dataTask.resume()
            }
        } else {
            print("Invalid URL")
            
        }
    }
    
}
