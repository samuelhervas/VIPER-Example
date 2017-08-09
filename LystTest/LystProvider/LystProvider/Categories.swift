//
//  Categories.swift
//  Lyst
//
//  Created by Samuel Hervás on 15/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//


import Moya


enum CategoryCall {
    case categories(gender: Gender,product: String, type: String)
}

extension CategoryCall: TargetType
{
    var parameters: [String : Any]? {
        get {
            switch self {
            case .categories(let gender, let product, let type) :
                let params = ["pre_gender" : gender.rawValue,
                              "pre_product_type" : product,
                              "filter_type" : type] as [String : Any]
                
                return params
            }
            
        }
    }
    
    var path: String {
        get {
            switch self {
            case .categories:
                return "components/filter_options"
            }
        }
    }
    
    var sampleData: Data {
        get { return Data()}
    }
    
    var multipartBody: [Moya.MultipartFormData]? {
        get { return nil }
    }
    
    var task : Task {
        get { return .request }
    }
    
    var method : Moya.Method {
        return .get
    }
    
    var baseURL: URL {
        return URL(string: "https://api.lyst.com/rest_api/")!
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}


