//
//  URLSessionPinningDelegate.swift
//  kintone-ios-sdk
//
//  Copyright © 2018 Cybozu. All rights reserved.
//

import Foundation
import Security

class URLSessionPinningDelegate: NSObject, URLSessionDelegate
{
    private var domain: String?
    private var password: String?
    private var certData: Data?
    private var usePath: Bool?
    private var certPath: String?
    
    public init(_ domain: String?) {
        self.domain = domain
    }
    
    public func setCertByData( _ certData: Data?, _ password: String?) {
        self.password = password
        self.certData = certData!
        self.usePath = false
    }
    
    public func setCertByPath(_ certPath: String?, _ password: String?) {
        self.password = password
        self.certPath = certPath!
        self.usePath = true
    }
    
    func didReceive(serverTrustChallenge challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let customRoot = Bundle.main.certificate(named: "MouseCA")
        let trust = challenge.protectionSpace.serverTrust!
        if trust.evaluateAllowing(rootCertificates: [customRoot]) {
            completionHandler(.useCredential, URLCredential(trust: trust))
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
    
    func didReceive(clientIdentityChallenge challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        var identity: (status: OSStatus, data:SecIdentity?)
        if self.usePath ?? false {
            identity = Bundle.main.identity(filepath: self.certPath!, password: self.password!)
        }
        else {
            identity = Bundle.main.identityData(certData: self.certData!, password: self.password!)
        }
        if (identity.status == errSecAuthFailed) {
            completionHandler(.performDefaultHandling, nil)
        }
        else {
            completionHandler(.useCredential, URLCredential(identity: identity.data!, certificates: nil, persistence: .forSession))
        }
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        var domainString = self.domain!
        if !domainString.hasPrefix("https://") {
            domainString = "https://" + domainString
        }
        switch (challenge.protectionSpace.authenticationMethod, "https://" + challenge.protectionSpace.host) {
        case (NSURLAuthenticationMethodClientCertificate, domainString):
            self.didReceive(clientIdentityChallenge: challenge, completionHandler: completionHandler)
        default:
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
