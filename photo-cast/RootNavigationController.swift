import UIKit

class RootNavigationController: UINavigationController
{
    init()
    {
        // todo: dependencies ...
        let photosService = PhotosService()

        super.init(nibName: nil, bundle: nil)
        let photosViewController = PhotosViewController(photosService: photosService)
        pushViewController(photosViewController, animated: false)
    }
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.title = "Photo Cast"
    }
}

