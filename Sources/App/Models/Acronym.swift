
import Vapor
import FluentSQLite

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
extension Acronym: SQLiteModel {
    typealias Database = SQLiteDatabase
    typealias ID = Int
    public static var idKey: IDKey = \Acronym.id
}

// Acronym conforms to Migration, you can tell Fluent to create the table when the application starts
extension Acronym: Migration {}

// Vapor provides Content, a wrapper around Codable, which allows you to convert models and other data between various formats.
extension Acronym: Content {}
