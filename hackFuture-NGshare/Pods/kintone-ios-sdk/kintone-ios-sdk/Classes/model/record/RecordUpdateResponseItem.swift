
//
//  RecordUpdateResponseItem.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/12.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

open class RecordUpdateResponseItem: NSObject, Codable {
    
    private var id: Int?
    private var revision: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case revision
    }
    
    public override init() {
    }
    
    /// get the ID of record
    ///
    /// - Returns: the ID of record
    open func getID() -> Int? {
        return self.id
    }
    
    /// set the ID of record
    ///
    /// - Parameter id: the ID of record
    open func setID(_ id: Int) {
        self.id = id;
    }
    
    /// get the number of revision
    ///
    /// - Returns: the number of revision
    open func getRevision() -> Int? {
        return self.revision;
    }
    
    /// set the number of revision
    ///
    /// - Parameter revision: the number of revision
    open func setRevision(_ revision: Int) {
        self.revision = revision;
    }
    
    public required init(from decoder: Decoder) throws {
        do {
            let parser = RecordParser()
            let response = try parser.parseForRecordUpdateResponseItem(decoder)
            self.id = response.getID()
            self.revision = response.getRevision()
        }
    }
    
}
