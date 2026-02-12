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
        //  TODO: Make later
    }
}



