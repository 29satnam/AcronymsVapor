
import Vapor
import FluentPostgreSQL

final class Acronym: Codable {
    var id: Int?
    var short: String
    var long: String
    
    init(short: String, long: String) {
        self.short = short
        self.long = long
    }
}

//extension Acronym: Model {
extension Acronym: PostgreSQLModel {}

// Acronym conforms to Migration, you can tell Fluent to create the table when the application starts
extension Acronym: Migration {}

// Vapor provides Content, a wrapper around Codable, which allows you to convert models and other data between various formats.
extension Acronym: Content {}

// Retrieve a single acronym
// Vapor’s powerful type safety for parameters extends to models that conform to Parameter. 
extension Acronym: Parameter {}

/*
 
 start the container that is already created with - docker start postgres
 delete the old container before trying to start it again - docker rm postgres. This is also a useful command if you want to reset your DB

 116 <24
 
 docker run --name postgres -e POSTGRES_DB=vapor   -e POSTGRES_USER=vapor -e POSTGRES_PASSWORD=password   -p 5432:5432 -d postgres
 
 */
