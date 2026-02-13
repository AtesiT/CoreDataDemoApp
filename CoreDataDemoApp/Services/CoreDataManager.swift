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
    
    public func fetchPhotos() -> [Photo] {
        //  Создаем запрос к базе данных, который получит все объекты с типом "Photo"
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            return (try? context.fetch(fetchRequest) as? [Photo]) ?? []
        }
    }
    
    public func fetchPhoto(_ id: Int16) -> Photo? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        do {
            //  Также - получаем список фото объектов. Затем кастим до массива фото.
            let photos = try? context.fetch(fetchRequest) as? [Photo]
            //  Если до этого мы получили массив с фото, то получаем самый первый объект, который равен ID который мы ищем
            return photos?.first(where: { $0.id == id })
        }
    }
    
    public func updatePhoto(with id: Int16, newUrl: String, title: String? = nil) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        do {
            guard let photos = try? context.fetch(fetchRequest) as? [Photo],
                  let photo = photos.first(where: { $0.id == id }) else {return}
            //  Записываем новые параметры в фото
            photo.url = newUrl
            photo.title = title
         
            appDelegate.saveContext()
        }
    }
    
    public func deleteAllPhotos() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        do {
            let photos = try? context.fetch(fetchRequest) as? [Photo]
            //  После массива мы проходим и удаляем все фото
            photos?.forEach { context.delete($0) }
        }
        appDelegate.saveContext()
    }
    
    public func deletePhoto(with id: Int16) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        
        do {
            guard let photos = try? context.fetch(fetchRequest) as? [Photo],
                  let photo = photos.first(where: { $0.id == id }) else {return}
            //  После того, как нашли нужное нам фото - удаляем его
            context.delete(photo)
        }
        appDelegate.saveContext()
    }
}



