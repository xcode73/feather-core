//
//  Form.swift
//  ViewKit
//
//  Created by Tibor Bodecs on 2020. 04. 22..
//


open class Form: FormComponent {

    public struct Action: Encodable {
        public enum Method: String, Encodable {
            case get
            case post
        }
        public let method: Method
        public let url: String?
        public let multipart: Bool
        
        public init(method: Method = .post,
                    url: String? = nil,
                    multipart: Bool = false) {
            self.method = method
            self.url = url
            self.multipart = multipart
        }
    }
    
    enum CodingKeys: CodingKey {
        case action
        case id
        case token
        case title
        case notification
        case fields
    }

    open var action: Action
    open var id: String
    open var token: String
    open var title: String
    open var notification: Notification?
    open var fields: [FormComponent]

    #warning("remove default params")
    init(title: String = "form", action: Action = .init(), fields: [FormComponent] = []) {
        self.action = action
        self.id = UUID().uuidString
        self.token = UUID().uuidString
        self.title = title
        self.fields = fields
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(action, forKey: .action)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(token, forKey: .token)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(notification, forKey: .notification)

        var fieldsArrayContainer = container.superEncoder(forKey: .fields).unkeyedContainer()
        for field in fields {
            try field.encode(to: fieldsArrayContainer.superEncoder())
        }
    }

    // MARK: - fields api

    func initializeFields(req: Request) -> EventLoopFuture<Void> {
        let futures = fields.map { $0.initialize(req: req) } + [initialize(req: req)]
        return req.eventLoop.flatten(futures)
    }

    func processFields(req: Request) throws {
        try fields.forEach { try $0.process(req: req) }
        try process(req: req)
    }
    
    func validateFields(req: Request) -> EventLoopFuture<Bool> {
        let futures = fields.map { $0.validate(req: req) } + [validate(req: req)]
        return req.eventLoop.mergeTrueFutures(futures)
    }

    func loadFields(req: Request) -> EventLoopFuture<Void> {
        let futures = fields.map { $0.load(req: req) } + [load(req: req)]
        return req.eventLoop.flatten(futures)
    }

    func saveFields(req: Request) -> EventLoopFuture<Void> {
        let futures = fields.map { $0.save(req: req) } + [save(req: req)]
        return req.eventLoop.flatten(futures)
        
    }
    
    func renderFields(req: Request) throws {
        try fields.forEach { try $0.render(req: req) }
        try render(req: req)
    }
    
    // MARK: - open api

    open func initialize(req: Request) -> EventLoopFuture<Void> {
        token = req.generateNonce(for: "form", id: id)
        return req.eventLoop.future()
    }
    
    open func process(req: Request) throws {
        
    }
    
    open func validate(req: Request) -> EventLoopFuture<Bool> {
        req.eventLoop.future(true)
    }

    open func load(req: Request) -> EventLoopFuture<Void> {
        req.eventLoop.future()
    }
    
    open func save(req: Request) -> EventLoopFuture<Void> {
        req.eventLoop.future()
    }
    
    open func render(req: Request) throws {
        
    }
}

//    func validate(req: Request) -> EventLoopFuture<Bool> {
//        validation
//            .validate(req)
//            .map { [unowned self] items -> [ValidationError] in
//                for item in items {
//                    if item.key == output.key {
//                        output.error = item.message
//                    }
//                }
//                return items
//            }
//            .map { $0.isEmpty }
//    }

