//
//  ApiUtils.swift
//  Demo
//
//  Created by CLships on 2024/6/10.
//

import UIKit
import Alamofire
import SwiftyJSON

class ApiUtils: NSObject {
    
    static func getApiMarquee(completion: @escaping(DemoResults)->Void) {
        AF.request(APIURL.marquee.path).responseJSON { (response) in
            switch response.result {
            case .success:
                if let result = response.data, let dataResult = try? JSONDecoder().decode(DemoResults.self, from: result) {
                    completion(dataResult)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getApiBanner(completion: @escaping(DemoResults)->Void) {
        AF.request(APIURL.banner.path).responseJSON { (response) in
            switch response.result {
            case .success:
                if let result = response.data, let dataResult = try? JSONDecoder().decode(DemoResults.self, from: result) {
                    completion(dataResult)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getApiCategory(completion: @escaping(DemoResults)->Void) {
        AF.request(APIURL.category.path).responseJSON { (response) in
            switch response.result {
            case .success:
                if let result = response.data, let dataResult = try? JSONDecoder().decode(DemoResults.self, from: result) {
                    completion(dataResult)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getApiNotification(completion: @escaping(DemoResults)->Void) {
        AF.request(APIURL.notification.path).responseJSON { (response) in
            switch response.result {
            case .success:
                if let result = response.data, let dataResult = try? JSONDecoder().decode(DemoResults.self, from: result) {
                    completion(dataResult)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getApiCampaign(completion: @escaping(DemoResults)->Void) {
        AF.request(APIURL.campaign.path).responseJSON { (response) in
            switch response.result {
            case .success:
                if let result = response.data, let dataResult = try? JSONDecoder().decode(DemoResults.self, from: result) {
                    completion(dataResult)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getApiActivities(completion: @escaping(DemoResults)->Void) {
        AF.request(APIURL.activities.path).responseJSON { (response) in
            switch response.result {
            case .success:
                if let result = response.data, let dataResult = try? JSONDecoder().decode(DemoResults.self, from: result) {
                    completion(dataResult)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getApiProducts(completion: @escaping(DemoResults)->Void) {
        AF.request(APIURL.products.path).responseJSON { (response) in
            switch response.result {
            case .success:
                if let result = response.data, let dataResult = try? JSONDecoder().decode(DemoResults.self, from: result) {
                    completion(dataResult)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getApiRecommend(completion: @escaping(DemoResults)->Void) {
        AF.request(APIURL.recommend.path).responseJSON { (response) in
            switch response.result {
            case .success:
                if let result = response.data, let dataResult = try? JSONDecoder().decode(DemoResults.self, from: result) {
                    completion(dataResult)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

enum APIURL {
    
    case marquee
    case banner
    case category
    case notification
    case campaign
    case activities
    case products
    case recommend
    
    var baseURL: String {
        return Bundle.main.infoDictionary!["Demo_Domain"] as! String
    }
    
    var path: String {
        switch self {
        case .marquee:
            return "\(baseURL)/demo/marquee"
        case .banner:
            return "\(baseURL)/demo/banner"
        case .category:
            return "\(baseURL)/demo/category"
        case .notification:
            return "\(baseURL)/demo/notification"
        case .campaign:
            return "\(baseURL)/demo/campaign"
        case .activities:
            return "\(baseURL)/demo2/activities"
        case .products:
            return "\(baseURL)/demo2/products"
        case .recommend:
            return "\(baseURL)/demo2/recommend"
        }
    }
}

extension Alamofire.DataRequest {
    func serializingDecodable<Value: Decodable>(_ type: Value.Type = Value.self) async throws -> Value {
        let result = await serializingData().result
        switch result {
        case .success(let data):
            do {
                return try JSONDecoder().decode(Value.self, from: data)
            } catch let error {
                throw error
            }
         
        case .failure(let error):
            throw error
        }
    }
}
