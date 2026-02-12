import Foundation
import CoreData

@objc(Photo)
//  Модель, которая хранит в себе описанный объект, который мы будем добавлять в базу данных и работать с ней
public class Photo: NSManagedObject {}

extension Photo {
    
    @NSManaged public var id: Int16
    @NSManaged public var url: String?
    @NSManaged public var title: String?

}

extension Photo : Identifiable {}
