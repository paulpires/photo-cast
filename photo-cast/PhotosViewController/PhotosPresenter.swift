import Foundation
import UIKit

protocol PhotosPresenterResponder
{
    func present(_ photos: [PhotoViewModel])
    func presentAccessPermissionRequired()
}

class PhotosPresenter
{
    private let photosService: PhotosServiceProtocol

    weak var responder: Responder?

    init(photosService: PhotosServiceProtocol)
    {
        self.photosService = photosService
    }

    func fetchPhotos()
    {
        photosService.allLocalPhotos { [weak self] result in
            switch result
            {
            case .success(let photos):
                print("photo collection count: \(photos.count)")
                let photoViewModels = photos.map(PhotoViewModel.init)
                self?.present(photoViewModels)
            case .failure(let error):
                self?.handle(error)
            }
        }
    }

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


}

struct PhotoViewModel
{
    let image: UIImage

    init(_ photo: Photo)
    {
        self.image = photo.image
    }
}
