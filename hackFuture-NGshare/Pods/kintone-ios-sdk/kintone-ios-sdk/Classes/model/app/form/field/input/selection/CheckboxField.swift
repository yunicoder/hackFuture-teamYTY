// Copyright (c) 2018 Cybozu, Inc.

open class CheckboxField: AbstractSelectionField {
    internal var defaultValue: [String]?
    internal var align: AlignLayout?
    
    enum CheckboxCodingKeys: CodingKey {
        case defaultValue
        case align
    }
   
    public override init() {
        super.init()
        self.type = FieldType.CHECK_BOX;
    }
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.CHECK_BOX
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CheckboxCodingKeys.self)
        self.defaultValue = try container.decode([String].self, forKey: CheckboxCodingKeys.defaultValue)
        self.align = try container.decode(AlignLayout.self, forKey: CheckboxCodingKeys.align)
        try super.init(from: decoder)
    }
    
    override open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CheckboxCodingKeys.self)
        if(self.defaultValue != nil){
            try container.encode(self.defaultValue, forKey: CheckboxCodingKeys.defaultValue)
        }
        if(self.align != nil){
            try container.encode(self.align, forKey: CheckboxCodingKeys.align)
        }
        try super.encode(to: encoder)
    }
    
    open func getAlign() -> AlignLayout? {
        return self.align
    }
    
    open func setAlign(_ align: AlignLayout?) {
        self.align = align
    }
    
    open func getDefaultValue() -> [String]? {
        return self.defaultValue
    }
    
    open func setDefaultValue(_ defaultValue: [String]?) {
        self.defaultValue = defaultValue
    }
}
