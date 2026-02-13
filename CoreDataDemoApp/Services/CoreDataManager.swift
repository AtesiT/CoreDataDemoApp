import UIKit
import CoreData

//  MARK: - CRUD
public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    
    private override init() {}
    
    //  Context - специальный контейнер, который доступен через PersistanceContainer
    //  PersistanceContainer - область в памяти, которая существует на данный момент для приложения нашего.
    //  В Core Data, чтобы работать с базой данных, необходимо получить доступ к PersistanceContainer (это делается через свойство appdelegate)
    private var appDelegate: AppDelegate {
        //  Приложение не упадет, потому что 100% скастится до AppDelegate
        URLSession.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    //  MARK: - Create
    public func createPhoto(_ id: Int16, _ title: String, _ url: String?) {
        guard let photoEntityDescription = NSEntityDescription.entity(forEntityName: "Photo", in: context) else {
            return
        }
        
        let photo = Photo(entity: photoEntityDescription, insertInto: context)
        photo.id = id
        photo.title = title
        photo.url = url
        
        appDelegate.saveContext()
    }
    
    
}



