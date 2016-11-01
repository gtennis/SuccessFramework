//
//  NetworkOperationFactoryProtocol.swift
//  _BusinessAppSwift_
//
//  Created by Gytenis Mikulenas on 18/10/2016.
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

protocol NetworkOperationFactoryProtocol {
 
    var userManager: UserManagerProtocol? {get set}
    
    init(appConfig: AppConfigEntity?, settingsManager: SettingsManagerProtocol)
    
    // MARK: Config
    func configNetworkOperation(context: Any?) -> NetworkOperationProtocol
    
    // MARK: Images
    func imageUploadNetworkOperation(context: Any?) -> NetworkOperationProtocol
    func imageListNetworkOperation(context: Any?) -> NetworkOperationProtocol
    
    // MARK: User
    func userLoginNetworkOperation(context: Any?) -> NetworkOperationProtocol
    func userSignUpNetworkOperation(context: Any?) -> NetworkOperationProtocol
    func userProfileNetworkOperation(context: Any?) -> NetworkOperationProtocol
    func userResetPasswordNetworkOperation(context: Any?) -> NetworkOperationProtocol
    
    // MARK: Legal
    func privacyPolicyNetworkOperation(context: Any?) -> NetworkOperationProtocol
    func termsConditionsNetworkOperation(context: Any?) -> NetworkOperationProtocol
}
