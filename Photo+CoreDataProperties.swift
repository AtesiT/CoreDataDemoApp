import Foundation
import CoreData

@objc(Photo)
public class Photo: NSManagedObject {}

extension Photo {
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
//        return NSFetchRequest<Photo>(entityName: "Photo")
//    }

    @NSManaged public var id: Int16
    @NSManaged public var url: String?

}

extension Photo : Identifiable {}
