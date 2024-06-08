//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 14..
//

import Vapor
import FeatherObjects

struct SystemRouter: FeatherRouter {

    let responseController = SystemResponseController()

    let adminDashboard = SystemAdminDashboardController()
    let permissionApi = SystemPermissionApiController()
    let permissionAdmin = SystemPermissionAdminController()
    let variableApi = SystemVariableApiController()
    let variableAdmin = SystemVariableAdminController()
    let metadataApi = SystemMetadataApiController()
    let metadataAdmin = SystemMetadataAdminController()
    let fileAdmin = SystemFileAdminController()
    let fileApi = SystemFileApiController()
    
    func boot(_ app: Application) throws {
        app.routes.get(app.feather.config.paths.manifest.pathComponent, use: responseController.renderManifestFile)
    }

    func config(_ app: Application) throws {
        let middlewares: [Middleware] = app.invokeAllFlat(.middlewares)
        let routes = app.routes
            .grouped([SystemInstallGuardMiddleware()])
            .grouped(middlewares)

        var arguments = HookArguments()
        arguments.routes = routes
        let _: [Void] = app.invokeAll(.routes, args: arguments)
    }
    
    func routesHook(args: HookArguments) {
        // MARK: - public api
        
        let publicApiMiddlewares: [Middleware] = args.app.invokeAllFlat(.publicApiMiddlewares)
        let publicApiRoutes = args.routes
            .grouped(args.app.feather.config.paths.api.pathComponent)
            .grouped([SystemApiErrorMiddleware()])
            .grouped(publicApiMiddlewares)
        
        publicApiRoutes.get("status") { _ in "ok" }
        publicApiRoutes.get(.catchall) { _ -> Response in throw Abort(.notFound) }
        publicApiRoutes.post(.catchall) { _ -> Response in throw Abort(.notFound) }
        publicApiRoutes.put(.catchall) { _ -> Response in throw Abort(.notFound) }
        publicApiRoutes.patch(.catchall) { _ -> Response in throw Abort(.notFound) }
        publicApiRoutes.delete(.catchall) { _ -> Response in throw Abort(.notFound) }
        
        var publicApiArguments = HookArguments()
        publicApiArguments.routes = publicApiRoutes
        let _: [Void] = args.app.invokeAll(.publicApiRoutes, args: publicApiArguments)

        // MARK: - api
        
        let apiMiddlewares: [Middleware] = args.app.invokeAllFlat(.apiMiddlewares)
        let apiRoutes = publicApiRoutes
            .grouped(apiMiddlewares)
        
        permissionApi.setUpRoutes(apiRoutes)
        variableApi.setUpRoutes(apiRoutes)
        metadataApi.setUpListRoutes(apiRoutes)
        metadataApi.setUpDetailRoutes(apiRoutes)
        metadataApi.setUpUpdateRoutes(apiRoutes)
        metadataApi.setUpPatchRoutes(apiRoutes)
        fileApi.setUpRoutes(apiRoutes)
        
        var apiArguments = HookArguments()
        apiArguments.routes = apiRoutes
        let _: [Void] = args.app.invokeAll(.apiRoutes, args: apiArguments)
        
        // MARK: - web
        
        let webMiddlewares: [Middleware] = args.app.invokeAllFlat(.webMiddlewares)
        let webRoutes = args.routes
            .grouped(FeatherMenuMiddleware())
            .grouped(webMiddlewares)
            .grouped(SystemErrorMiddleware())
        
        var webArguments = HookArguments()
        webArguments.routes = webRoutes
        let _: [Void] = args.app.invokeAll(.webRoutes, args: webArguments)
        
        // MARK: - admin
       
//        let path: String? = args.app.invoke(.loginPath)
        let adminMiddlewares: [Middleware] = args.app.invokeAllFlat(.adminMiddlewares)
        let adminRoutes = args.routes
            .grouped(args.app.feather.config.paths.admin.pathComponent)
            .grouped(FeatherMenuMiddleware())
            .grouped(adminMiddlewares)
            .grouped([
                AccessRedirectMiddleware(FeatherSystem.permission(for: .detail), path: "/"),
                SystemAdminErrorMiddleware(),
            ])

        adminRoutes.get(use: adminDashboard.renderDashboardTemplate)
        adminRoutes.get(FeatherSystem.pathKey.pathComponent) { req -> Response in
            let template = SystemAdminModulePageTemplate(.init(title: "System",
                                                               tag: SystemAdminWidgetTemplate().render(req)))
            return req.templates.renderHtml(template)
        }
        adminRoutes.get(.catchall) { _ -> Response in throw Abort(.notFound) }
        adminRoutes.post(.catchall) { _ -> Response in throw Abort(.notFound) }
        
        permissionAdmin.setUpRoutes(adminRoutes)
        variableAdmin.setUpRoutes(adminRoutes)
        metadataAdmin.setUpListRoutes(adminRoutes)
        metadataAdmin.setUpDetailRoutes(adminRoutes)
        metadataAdmin.setUpUpdateRoutes(adminRoutes)
        fileAdmin.setUpRoutes(adminRoutes)

        var adminArguments = HookArguments()
        adminArguments.routes = adminRoutes
        let _: [Void] = args.app.invokeAll(.adminRoutes, args: adminArguments)

        // MARK: - public web
        
        webRoutes.get(use: responseController.handle)
        webRoutes.get(.catchall, use: responseController.handle)
        webRoutes.post(.catchall, use: responseController.handle)
    }
    
}