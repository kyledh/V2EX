//
//  KDAPIClient.swift
//  qducc
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit

import Alamofire

class KDAPIClient {
    
    static let sharedClient: KDAPIClient = {
        let client = KDAPIClient()
        return client
    }()
    
    func getRequest(path: String, params: [String : AnyObject],
                    success: @escaping (_ responseObject: [String : AnyObject]) -> (), failture: @escaping (_ error: NSError) -> ())
    {
        request(method: .get, path: path, params: params, success: { (responseObject) in
            success(responseObject)
        }, failture: { (error) in
            failture(error)
        })
    }
    
    func postRequest(path: String, params: [String : AnyObject],
                     success: @escaping (_ responseObject: [String : AnyObject]) -> (), failture: @escaping (_ error: NSError) -> ())
    {
        request(method: .post, path: path, params: params, success: { (responseObject) in
            success(responseObject)
        }, failture: { (error) in
            failture(error)
        })
    }
    
    private func request(method: HTTPMethod, path: String, params: [String : AnyObject],
                         success: @escaping (_ responseObject: [String : AnyObject]) -> (), failture: @escaping (_ error: NSError) -> ())
    {
        let urlString = KDConfigUtil.APIHost() + path
        Alamofire.request(urlString, method: method, parameters: params)
            .responseJSON {response in
                switch response.result {
                case .success:
                    if let value = response.result.value as? [String : AnyObject] {
                        success(value)
                    }
                case .failure(let error):
                    failture(error as NSError)
                }
        }
    }
}
