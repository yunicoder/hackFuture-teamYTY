// Copyright (c) 2018 Cybozu, Inc.

open class SingleLineTextField: AbstractInputField {
    private var expression: String?
    private var hideExpression: Bool?
    private var minLength: String?
    private var maxLength: String?
    private var defaultValue: String?
    private var unique: Bool?
    
    enum SingleLineTextCodingKeys: CodingKey {
        case expression
        case hideExpression
        case minLength
        case maxLength
        case defaultValue
        case unique
    }
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.SINGLE_LINE_TEXT
    }
    
    open func getMinLength() -> String? {
        return self.minLength
    }
    
    open func setMinLength(_ minLength: String?) {
        self.minLength = minLength
    }
    
    open func getMaxLength() -> String? {
        return self.maxLength
    }
    
    open func setMaxLength(_ maxLength: String?) {
        self.maxLength = maxLength
    }
    
    open func getExpression() -> String? {
        return self.expression
    }
    
    open func setExpression(_ expression: String?) {
        self.expression = expression
    }
  
    open func getHideExpression() -> Bool? {
        return self.hideExpression
    }
    
    open func setHideExpression(_ hideExpression: Bool?) {
        self.hideExpression = hideExpression
    }
    
    open func getDefaultValue() -> String? {
        return self.defaultValue
    }
    
    open func setDefaultValue(_ defaultValue: String?) {
        self.defaultValue = defaultValue
    }
  
    open func getUnique() -> Bool? {
        return self.unique
    }
    
    open func setUnique(_ isUnique: Bool?) {
        self.unique = isUnique
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SingleLineTextCodingKeys.self)
        self.expression = try container.decode(String.self, forKey: SingleLineTextCodingKeys.expression)
        self.hideExpression = try container.decode(Bool.self, forKey: SingleLineTextCodingKeys.hideExpression)
        self.minLength = try container.decode(String.self, forKey: SingleLineTextCodingKeys.minLength)
        self.maxLength = try container.decode(String.self, forKey: SingleLineTextCodingKeys.maxLength)
        self.defaultValue = try container.decode(String.self, forKey: SingleLineTextCodingKeys.defaultValue)
        self.unique = try container.decode(Bool.self, forKey: SingleLineTextCodingKeys.unique)
        try super.init(from: decoder)
    }
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SingleLineTextCodingKeys.self)
        if(self.expression != nil)
        {
            try container.encode(self.expression, forKey: SingleLineTextCodingKeys.expression)
        }
        if(self.hideExpression != nil){
            try container.encode(self.hideExpression, forKey: SingleLineTextCodingKeys.hideExpression)
        }
        if(self.minLength != nil){
            try container.encode(self.minLength, forKey: SingleLineTextCodingKeys.minLength)
        }
        if(self.maxLength != nil){
            try container.encode(self.maxLength, forKey: SingleLineTextCodingKeys.maxLength)
        }
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: SingleLineTextCodingKeys.defaultValue)
        }
        if(self.unique != nil){
            try container.encode(self.unique, forKey: SingleLineTextCodingKeys.unique)
        }
        try super.encode(to: encoder)
    }
}
