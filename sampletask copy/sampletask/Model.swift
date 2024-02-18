//
//  Model.swift
//  sampletask
//
//  Created by Vinay on 10/01/24.
//

//import Foundation

//struct ToDo: Codable {
////    let message: String
////    let status: Int
////    let data: [Category]
//    let albumId: Int
//    let id: Int
//    let title: String
//    let url: URL
//    let thumbnailUrl: String
//}

//struct Category: Codable {
//    let id: Int
//    let name: String
//    let typeOfCategory: String
//    let parentId: Int
//    let parentName: String
//    let imgUrl: String?
//    let appIcon: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case typeOfCategory = "type_of_category"
//        case parentId = "parent_id"
//        case parentName = "parent_name"
//        case imgUrl = "img_url"
//        case appIcon = "app_icon"
//    }
//}


import Foundation

// Define a model for the user data
struct User: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id, email, avatar
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

// Define a model for the pagination information
//struct PaginationInfo: Codable {
//    var page: Int
//    let perPage: Int
//    let total: Int
//    let totalPages: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case page
//        case perPage = "per_page"
//        case total
//        case totalPages = "total_pages"
//    }
//}

// Define a model for the support information
struct Support: Codable {
    let url: String
    let text: String
}

// Define the top-level model that includes user data, pagination, and support info
struct ApiResponse: Codable {
    var data: [User]
    let support: Support
    var page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case data, support
        /*case pagination = "page"*/ // Assuming you want to map the pagination info directly under "page"
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
    }
    
    // Custom init to integrate pagination data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([User].self, forKey: .data)
        support = try container.decode(Support.self, forKey: .support)
        
        page = try container.decode(Int.self, forKey: .page)
        perPage = try container.decode(Int.self, forKey: .perPage)
        total = try container.decode(Int.self, forKey: .total)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        
        
    }
}
