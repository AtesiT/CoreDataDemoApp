import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.shared.fetchPhotos()
//        CoreDataManager.shared.createPhoto(1, title: "1", url: "https://www.google.com")
    }


}

