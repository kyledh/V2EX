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

    func getRequest(path: String?, params: [String : AnyObject]?,
                    success: @escaping (_ responseObject:  AnyObject) -> (), failture: @escaping (_ error: NSError) -> ())
    {
        request(method: .get, path: path ?? "", params: params ?? ["": "" as AnyObject], success: { (responseObject) in
            success(responseObject)
        }, failture: { (error) in
            failture(error)
        })
    }
    
    func postRequest(path: String, params: [String : AnyObject],
                     success: @escaping (_ responseObject: AnyObject) -> (), failture: @escaping (_ error: NSError) -> ())
    {
        request(method: .post, path: path, params: params, success: { (responseObject) in
            success(responseObject)
        }, failture: { (error) in
            failture(error)
        })
    }
    
    private func request(method: HTTPMethod, path: String, params: [String : AnyObject],
                         success: @escaping (_ responseObject: AnyObject) -> (), failture: @escaping (_ error: NSError) -> ())
    {
        let urlString = KDConfig.APIHost() + path;
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.request(urlString, method: method, parameters: params)
            .responseString { (response) in
                switch response.result {
                case .success:
                    success(response.result.value as AnyObject)
                case .failure(let error):
                    failture(error as NSError)
                }
        }
    }
}

