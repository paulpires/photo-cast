import UIKit

class PhotosViewController
    : UIViewController
    , PhotosPresenterResponder
{
    let presenter: PhotosPresenter

    let label: UILabel

    init(photosService: PhotosServiceProtocol)
    {
        presenter = PhotosPresenter(photosService: photosService)
        label = UILabel()
        super.init(nibName: nil, bundle: nil)
        presenter.responder = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Photo Cast"
        label.text = "Loading ..."
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.fetchPhotos()
    }

    // MARK: PhotosPresenterResponder

    func present(_ photos: [PhotoViewModel])
    {
        label.text = "Loaded with \(photos.count) photos."
    }

    func presentAccessPermissionRequired()
    {
        label.text = "Gimme access to your photos via the Settings app!"
    }
}
