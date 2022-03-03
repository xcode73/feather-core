//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 02. 23..
//

public extension HookName {
    static let response: HookName = "response"
    
    static let routes: HookName = "routes"
    static let middlewares: HookName = "middlewares"
    
    static let apiRoutes: HookName = "api-routes"
    static let apiMiddlewares: HookName = "api-middlewares"
    
    static let publicApiRoutes: HookName = "public-api-routes"
    static let publicApiMiddlewares: HookName = "public-api-middlewares"
    
    static let webMenu: HookName = "web-menu"
    static let webRoutes: HookName = "web-routes"
    static let webMiddlewares: HookName = "web-middlewares"

    static let install: HookName = "install"
    static let installStep: HookName = "install-step"
    static let installResponse: HookName = "install-response"
    static let installPermissions: HookName = "install-permissions"
    static let installVariables: HookName = "install-variables"
    
    static let filters: HookName = "filters"
    
    static let adminRoutes: HookName = "admin-routes"
    static let adminMiddlewares: HookName = "admin-middlewares"
    static let adminWidgets: HookName = "admin-widgets"
    
    static let adminAssets: HookName = "admin-assets"
    static let adminCss: HookName = "admin-css"
    static let adminJs: HookName = "admin-js"
    
    static let guestRole: HookName = "guestRole"
    static let authenticatedRole: HookName = "authenticatedRole"
    static let rootRole: HookName = "rootRole"
    
    static let permission: HookName = "permission"
    static let access: HookName = "access"
}