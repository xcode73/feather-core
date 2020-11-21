//
//  ApiModule.swift
//  Feather
//
//  Created by Tibor Bödecs on 2020. 06. 09..
//

final class ApiModule: ViperModule {

    static var name: String = "api"
    var priority: Int { 2000 }

    var router: ViperRouter? { ApiRouter() }
    
    func boot(_ app: Application) throws {
        app.hooks.register("routes", use: (router as! ApiRouter).routesHook)
    }
}