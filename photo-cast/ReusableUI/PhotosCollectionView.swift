import UIKit

protocol PhotosCollectionViewDataSource
{
    func viewModels() -> [PhotoViewModel]
    func viewModel(forItemAt indexPath: IndexPath) -> PhotoViewModel
}

class PhotosCollectionView
    : UIView
    , UICollectionViewDataSource
    , UICollectionViewDelegate
{
    var dataSource: PhotosCollectionViewDataSource?

    private let collectionView: UICollectionView

    // MARK: public
    override init(frame: CGRect)
    {
        collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: frame)

        collectionView.delegate = self
        collectionView.dataSource = self
        let reuseId = String(describing: PhotosCollectionViewCell.self)
        collectionView.register(PhotosCollectionViewCell.self,
                                forCellWithReuseIdentifier: reuseId)

        addSubview(collectionView)
        collectionView.pinToSafeAreaEdges(to: self)

        collectionView.backgroundColor = .clear
    }
    @available(*, unavailable)
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) not supported")
    }

    func reload()
    {
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource -

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int
    {
        assert(dataSource != nil, "missing datasource")
        return dataSource?.viewModels().count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        assert(dataSource != nil, "missing datasource")

        let reuseId = String(describing: PhotosCollectionViewCell.self)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId,
                                                            for: indexPath) as? PhotosCollectionViewCell else
        {
            assertionFailure("Couldn't dequeue \(reuseId)")
            return UICollectionViewCell()
        }
        guard let viewModel = dataSource?.viewModel(forItemAt: indexPath) else
        {
            assertionFailure("Couldn't get viewModel for \(indexPath)")
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel)
        return cell
    }
}
