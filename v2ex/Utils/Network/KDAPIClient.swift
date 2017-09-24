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
    
    func getRequestWithoutCache(path: String, params: [String : AnyObject],
                    success: @escaping (_ responseObject:  AnyObject) -> (), failture: @escaping (_ error: NSError) -> ())
    {
        requestWithoutCache(method: .get, path: path, params: params, success: { (responseObject) in
            success(responseObject)
        }, failture: { (error) in
            failture(error)
        })
    }
    
    func getRequest(path: String, params: [String : AnyObject],
                    success: @escaping (_ responseObject:  AnyObject) -> (), failture: @escaping (_ error: NSError) -> ())
    {
        request(method: .get, path: path, params: params, success: { (responseObject) in
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
        let urlString = KDConfigUtil.APIHost() + path
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.request(urlString, method: method, parameters: params)
            .responseJSON {response in
                switch response.result {
                case .success:
                    success(response.result.value as AnyObject)
                case .failure(let error):
                    failture(error as NSError)
                }
        }
    }
    
    private func requestWithoutCache(method: HTTPMethod, path: String, params: [String : AnyObject],
                         success: @escaping (_ responseObject: AnyObject) -> (), failture: @escaping (_ error: NSError) -> ())
    {
        let urlString = KDConfigUtil.APIHost() + path
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.requestWithoutCache(urlString, method: method, parameters: params)
            .responseJSON {response in
                switch response.result {
                case .success:
                    success(response.result.value as AnyObject)
                case .failure(let error):
                    failture(error as NSError)
                }
        }
    }
}

extension Alamofire.SessionManager{
    @discardableResult
    open func requestWithoutCache(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)
        -> DataRequest
    {
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = .reloadIgnoringCacheData
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            print(error)
            return request(URLRequest(url: URL(string: "http://example.com/wrong_request")!))
        }
    }
}
