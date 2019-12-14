//
//  BulkRequestItem.swift
//  kintone-ios-sdk
//
//  Created by h001218 on 2018/09/17.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class BulkRequestItem: NSObject, Codable {
    
    private var method: String?
    private var api: String?
    private var payload: Any?
    
    enum CodingKeys: String, CodingKey {
        case method
        case api
        case payload
    }
    
    public override init() {
    }
    
    /// Get http method
    ///
    /// - Returns: http method
    open func getMethod() -> String? {
        return self.method
    }
    
    /// Set http method
    ///
    /// - Parameter method: http method
    open func setMethod(_ method: String) {
        self.method = method
    }
    
    /// Get api
    ///
    /// - Returns: self.api
    open func getApi() -> String? {
        return self.api
    }
    
    /// Set api
    ///
    /// - Parameter api: api
    open func setApi(_ api: String) {
        self.api = api
    }
    
    /// Get payload
    ///
    /// - Returns: self.payload
    open func getPayload() -> Any? {
        return self.payload
    }
    
    /// Set payload
    ///
    /// - Parameter payload: <#payload description#>
    open func setPayload(_ payload: Any) {
        self.payload = payload
    }
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - method: <#method description#>
    ///   - api: <#api description#>
    ///   - payload: <#payload description#>
    /// - Throws: <#throws value description#>
    public required init(_ method: String?, _ api: String?, _ payload: Any?) throws {
        self.method = method
        self.api = api
        self.payload = payload
    }
    
    /// Convert Json to BulkRequestItem.class
    ///
    /// - Parameter decoder:
    /// - Throws:
    public required init(from decoder: Decoder) throws {
        do {
            let parser = BulkRequestParser()
            let br = try parser.parseJsonToBulkRequestItem(decoder)
            self.method = br.getMethod()
            self.api = br.getApi()
        }
    }
    
    /// convert BulkRequestItem.class to Json
    ///
    /// - Parameter encoder:
    /// - Throws:
    open func encode(to encoder: Encoder) throws {
        do {
                let parser = BulkRequestParser()
                try parser.parseBulkRequestToJson(to: encoder, self.method, self.api, self.payload)
        }
    }
}
