//
//  KDAPIClient.swift
//  qducc
//
//  Created by donghao on 2017/9/23.
//  Copyright © 2017年 kyle. All rights reserved.
//

import UIKit
import Alamofire

public typealias SuccessClosure = (_ data: Data?) -> Void
public typealias FailureClosure = (_ error: Error?) -> Void

class KDAPIClient {
    
    static let shared = KDAPIClient()

    public func getRequest(path: String?,
                           params: [String : Any]?,
                           success: SuccessClosure?,
                           failure: FailureClosure?)
    {
        request(method: .get,
                path: path,
                params: params,
                success: { data in
                    success?(data)
        },
                failure: { error in
                    failure?(error)
        })
    }
    
    public func postRequest(path: String?,
                           params: [String : Any]?,
                           success: SuccessClosure?,
                           failure: FailureClosure?)
    {
        request(method: .post,
                path: path,
                params: params,
                success: { data in
                    success?(data)
        },
                failure: { error in
                    failure?(error)
        })
    }
    
    private func request(method: HTTPMethod,
                         path: String?,
                         params: [String : Any]?,
                         success: SuccessClosure?,
                         failure: FailureClosure?)
    {
        let urlString = KDConfig.APIHost() + (path ?? "");
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.request(urlString, method: method, parameters: params)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    success?(data)
                case .failure(let error):
                    failure?(error)
                }
        }
    }
}

