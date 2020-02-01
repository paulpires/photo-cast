import UIKit

class PhotosViewController
    : UIViewController
    , PhotosPresenterResponder
{
    private let presenter: PhotosPresenter
    private let label: UILabel
    private let photosCollectionView: PhotosCollectionView

    // MARK: public
    init(photosService: PhotosServiceProtocol)
    {
        presenter = PhotosPresenter(photosService: photosService)
        label = UILabel()
        photosCollectionView = PhotosCollectionView()
        photosCollectionView.dataSource = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.responder = self
    }
    @available(*, unavailable)
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) not supported")
    }

    // MARK: lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.title = "Photo Cast"

        view.backgroundColor = .white

        view.addSubview(label)
        label.text = "Loading ..."
        label.center(in: view)

        view.addSubview(photosCollectionView)
        photosCollectionView.pinToSafeAreaEdges(to: view)
        photosCollectionView.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        presenter.fetchPhotos()
    }

    // MARK: PhotosPresenterResponder
    func present(_ photos: [PhotoViewModel])
    {
        photosCollectionView.isHidden = false
        photosCollectionView.reload()
        label.isHidden = true
    }
    func presentAccessPermissionRequired()
    {
        photosCollectionView.isHidden = true
        label.isHidden = false
        label.text = "Gimme access to your photos via the Settings app!"
    }
}
