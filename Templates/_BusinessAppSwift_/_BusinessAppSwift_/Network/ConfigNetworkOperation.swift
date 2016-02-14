//
//  ConfigNetworkOperation.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 21/10/2016.
//  Copyright © 2016 Gytenis Mikulėnas 
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

import UIKit
import Alamofire

class ConfigNetworkOperation: BaseNetworkOperation {

    // MARK: NetworkOperationProtocol
    
    override func perform(callBack: @escaping Callback) {
        
        // Unit tests with examples: https://github.com/Alamofire/Alamofire/tree/master/Tests
        
        let urlString = "http://dotheapp.com/ws/config.json"
        //let headers = ["Method": "123456"]
        //let parameters = ["foo": "bar"]
        
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            //print(response.request)  // original URL request
            //print(response.response) // URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            // Explicitly make it clear about the content in response.result.value: it's dictionary
            let dictOptional: Dictionary <String, AnyObject>? = response.result.value as! Dictionary<String, AnyObject>?
            
            if let dict = dictOptional {
                
                let appConfigEntity: AppConfigEntity = AppConfigEntity.init(dict: dict);
                
                // TODO: check values
                callBack(true, appConfigEntity, nil, nil)
            } else {
                
                // TODO: ...
                callBack(false, nil, nil, nil)
            }
        }
    }
}
