// Copyright (c) 2018 Cybozu, Inc.

open class MemberSelectEntity: NSObject, Codable {
    private var code: String?
    private var type: MemberSelectEntityType?
    
    public override init(){
         super.init()
    }

    public init(_ code: String?, _ type: MemberSelectEntityType?) {
        self.code = code
        self.type = type
    }
    
    open func getCode() -> String? {
        return self.code
    }
    
    open func setCode(_ code: String?) {
        self.code = code
    }
   
    open func getType() -> MemberSelectEntityType? {
        return self.type
    }
   
    open func setType(_ type: MemberSelectEntityType?) {
        self.type = type
    }

    open func equals(_ obj: AnyObject?) -> Bool? {
        if (obj == nil) {
            return false
        }
        if (!(obj is MemberSelectEntity)) {
            return false
        }
        
        let other = obj as! MemberSelectEntity
        if (self.code!.isEmpty) {
            if (other.code!.isEmpty) {
                return false
            }
        } else if (!(self.code == other.code)) {
            return false
        }
        if (self.type != other.type) {
            return false
        }
        return true
    }
}

