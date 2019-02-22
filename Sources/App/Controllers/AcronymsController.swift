
import Vapor
import Fluent

struct AcronymsController: RouteCollection {
    
    
    func getAllHandler(_ req: Request) throws -> Future<[Acronym]> {
        return Acronym.query(on: req).all()
    }
    
    
    func boot(router: Router) throws {
        router.get("api", "acronyms", use: getAllHandler)
        
        // Saving models
        router.post("api", "acronyms") { req -> Future<Acronym> in
            return try req.content.decode(Acronym.self)
                .flatMap(to: Acronym.self) { acronym in
                    return acronym.save(on: req)
            }
        }
        
        // Retrieve all acronyms
        router.get("api", "acronyms") { (req) -> Future<[Acronym]> in
            return Acronym.query(on: req).all()
        }
        
        // Retrieve a single acronym
        router.get("api", "acronyms", Acronym.parameter) {
            req -> Future<Acronym> in
            return try req.parameters.next(Acronym.self)
        }
        
        // Update
        router.put("api", "acronyms", Acronym.parameter) {
            req -> Future<Acronym> in
            // Use flatMap(to:_:_:), the dual future form of flatMap, to wait for both the parameter extraction and content decoding to complete. This provides both the acronym from the database and acronym from the request body to the closure.
            return try flatMap(to: Acronym.self, req.parameters.next(Acronym.self), req.content.decode(Acronym.self)) {
                acronym, updatedAcronym in
                
                acronym.short = updatedAcronym.short
                acronym.long = updatedAcronym.long
                
                return acronym.save(on: req)
            }
        }
        
        // Delete
        router.delete("api", "acronyms", Acronym.parameter) { req -> Future<HTTPStatus> in
            return try req.parameters.next(Acronym.self).delete(on: req).transform(to: HTTPStatus.noContent)
        }
        
        // Filter
        router.get("api", "acronyms", "search") {
            req -> Future<[Acronym]> in
            // 2
            guard
                let searchTerm = req.query[String.self, at: "term"] else {
                    throw Abort(.badRequest)
            }
            // 3
            return Acronym.query(on: req)
                .filter(\.short == searchTerm)
                .all()
        }
    }
}
