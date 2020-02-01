import UIKit

class PhotosCollectionViewCell: UICollectionViewCell
{
    private let imageView = UIImageView()

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.pinToSafeAreaEdges(to: self)
    }
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) not implemented")
    }

    func configure(with photoViewModel: PhotoViewModel)
    {
        imageView.image = photoViewModel.image
    }

    override func prepareForReuse()
    {
        imageView.image = nil
    }
}
