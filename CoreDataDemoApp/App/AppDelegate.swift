import UIKit
import CoreData

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { description, error in
            if let error {
                print(error)
            } else {
                //  Адрес объекта в памяти, по которому хранится наша база данных
                print("URL Database:", description.url?.absoluteString)
            }
        }
        return container
    }()
    //  Container - записан на жестком диске, а context - часть данных, с которыми мы работаем в ОЗУ на данный момент.
    //  SaveContext позволяет записать измененные данные в БД, без него мы изменим только данные в ОЗУ.
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as? NSError
                fatalError(error?.localizedDescription)
            }
        }
    }
}

