//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 04. 15..
//

extension RoleListObject: Content {}
extension RoleGetObject: Content {}
extension RoleCreateObject: Content {}
extension RoleUpdateObject: Content {}
extension RolePatchObject: Content {}

struct SystemRoleApi: FeatherApiRepresentable {
    typealias Model = SystemRoleModel
    
    typealias ListObject = RoleListObject
    typealias GetObject = RoleGetObject
    typealias CreateObject = RoleCreateObject
    typealias UpdateObject = RoleUpdateObject
    typealias PatchObject = RolePatchObject
    
    func mapList(model: Model) -> ListObject {
        .init(id: model.id!, name: model.name)
    }
    
    func mapGet(model: Model) -> GetObject {
        .init(id: model.id!,
              key: model.key,
              name: model.name,
              notes: model.notes)
    }
    
    func mapCreate(model: Model, input: CreateObject) {
        key = input.key
        name = input.name
        notes = input.notes
    }
    
    func mapUpdate(model: Model, input: UpdateObject) {
        key = input.key
        name = input.name
        notes = input.notes
    }

    func mapPatch(model: Model, input: PatchObject) {
        key = input.key ?? key
        name = input.name ?? name
        notes = input.notes ?? notes
    }
    
    func validateCreate(_ req: Request) -> EventLoopFuture<Bool> {
//        validations.add("key", as: String.self, is: !.empty && .count(...250))
//        validations.add("name", as: String.self, is: !.empty && .count(...250))
        req.eventLoop.future(true)
    }
    
    func validateUpdate(_ req: Request) -> EventLoopFuture<Bool> {
//        validations.add("key", as: String.self, is: !.empty && .count(...250))
//        validations.add("name", as: String.self, is: !.empty && .count(...250))
        req.eventLoop.future(true)
    }
    
    func validatePatch(_ req: Request) -> EventLoopFuture<Bool> {
//        validations.add("key", as: String.self, is: !.empty && .count(...250), required: false)
//        validations.add("name", as: String.self, is: !.empty && .count(...250), required: false)
        req.eventLoop.future(true)
    }
}