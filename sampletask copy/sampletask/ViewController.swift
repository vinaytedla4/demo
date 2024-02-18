//
//  ViewController.swift
//  sampletask
//
//  Created by Vinay on 10/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    var toDoList: ApiResponse?
    @IBOutlet weak var tableview: UITableView!
    var flag : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // self.tableview.register(RecordingCell2.self, forCellReuseIdentifier: "vinay")
        
        

        ImageLoader.shared.fetchingAPI(pageno : toDoList?.page ?? 1){ result in
            self.toDoList = result
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
//    func fetchingAPI(pageno : Int, completion: @escaping (ApiResponse) -> Void) {
//        
//        
//        let url : String = "https://reqres.in/api/users?page=\(pageno)"
//        if let url = URL(string: url) {
//            let session = URLSession.shared
//            
//            DispatchQueue.global().asyncAfter(deadline: .now() + 3){
//                let dataTask = session.dataTask(with: url) { data, response, error in
//                    if let data = data, error == nil {
//                        // Print the JSON response
//                        if let jsonString = String(data: data, encoding: .utf8) {
//                            print("Received JSON: \(jsonString)")
//                        }
//                        
//                        do {
//                            
//
//                            let parsingData = try JSONDecoder().decode(ApiResponse.self, from: data)
//                            completion(parsingData)
//
//                            
//                        } catch {
//                            print("Parsing error: \(error)")
//                            
//                        }
//                    } else {
//                        print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
//                        
//                    }
//                }
//                dataTask.resume()
//            }
//        } else {
//            print("Invalid URL")
//            
//        }
//    }
    
    
    
    func createTableFooter() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = footerView.center
        footerView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        self.tableview.tableFooterView = footerView
    }

    func removeTableFooter() {
        self.tableview.tableFooterView = nil
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vinay", for: indexPath)
        if let category = toDoList?.data[indexPath.row] {
            
            ImageLoader.shared.loadImage(from: category.avatar) { image in
                if let cell1 = cell as? RecordingCell2{
                    cell1.labl?.text = category.firstName
                    cell1.photo.image = image
                    
                }
           }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       if let users = toDoList?.data{
           if indexPath.row == (toDoList?.data.count)! - 1{
               print("reached last")
               if (toDoList?.data.count)! < toDoList!.total{
                   createTableFooter()
                   ImageLoader.shared.fetchingAPI(pageno: (toDoList?.page ?? 1)+1) { result in
                   self.toDoList?.page = result.page
                   self.toDoList?.data.append(contentsOf: result.data)
                   DispatchQueue.main.async {
                       self.tableview.reloadData()
                       self.removeTableFooter()
                   }
               }
           }
            }
        }
    }

        
    
}



//class ImageLoader {
//    static let shared = ImageLoader()
//    private var imageCache = NSCache<NSString, UIImage>()
//
//    private init() {}
//
//    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
//        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
//            completion(cachedImage)
//            return
//        }
//
//        guard let url = URL(string: urlString) else {
//            completion(nil)
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            guard let data = data, let image = UIImage(data: data), error == nil else {
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//                return
//            }
//
//            self?.imageCache.setObject(image, forKey: urlString as NSString)
//            DispatchQueue.main.async {
//                completion(image)
//            }
//        }.resume()
//    }
//}

