import Vapor

public func configure(_ app: Application) throws {
    app.middleware = Middlewares()
    app.middleware.use(CommonErrorMiddleware())
    app.middleware.use(CustomHeaderMiddleware())
    let publicDirectory = "\(app.directory.publicDirectory)/dist"
    app.middleware.use(FileMiddleware(publicDirectory: publicDirectory))
    
    app.http.server.configuration.supportPipelining = true
    app.http.server.configuration.requestDecompression = .enabled
    app.http.server.configuration.responseCompression = .enabled
    
    try routes(app)
}
