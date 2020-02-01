import Foundation
import UIKit

protocol PhotosPresenterResponder
{
    func present(_ photos: [PhotoViewModel])
    func presentAccessPermissionRequired()
}

class PhotosPresenter
    : PhotosCollectionViewDataSource
{
    weak var responder: Responder?

    private let photosService: PhotosServiceProtocol
    private var photoViewModels: [PhotoViewModel]

    // MARK: public -
    init(photosService: PhotosServiceProtocol)
    {
        self.photosService = photosService
        photoViewModels = []
    }
    func fetchPhotos()
    {
        photosService.allLocalPhotos { [weak self] result in
            switch result
            {
            case .success(let photos):
                print("photo collection count: \(photos.count)")
                let photoViewModels = photos.map(PhotoViewModel.init)
                self?.photoViewModels = photoViewModels
                self?.present(photoViewModels)
            case .failure(let error):
                self?.handle(error)
            }
        }
    }

    // MARK: private
    private func present(_ photos: [PhotoViewModel])
    {
        DispatchQueue.main.async
        {
            let photosResponder: PhotosPresenterResponder? = self.responder?.findConformingResponder()
            photosResponder?.present(photos)
        }
    }
    private func handle(_ error: PhotosServiceError)
    {
        switch error
        {
        case .noAccess:
            DispatchQueue.main.async
            {
                let photosResponder: PhotosPresenterResponder? = self.responder?.findConformingResponder()
                photosResponder?.presentAccessPermissionRequired()
            }
        }
    }

    // MARK: PhotosCollectionViewDataSource -
    func viewModels() -> [PhotoViewModel]
    {
        photoViewModels
    }
    func viewModel(forItemAt indexPath: IndexPath) -> PhotoViewModel
    {
        return photoViewModels[indexPath.row]
    }
}

private extension PhotoViewModel
{
    init(_ photo: Photo)
    {
        self.image = photo.image
    }
}
