import Vapor
import Fluent

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let acronymsController = AcronymsController()
    //Create a new AcronymsController.

    try router.register(collection: acronymsController)
    //Register the new type with the router to ensure the controller’s routes get registered.

}
// Page 120
