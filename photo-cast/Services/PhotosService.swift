import Foundation
import Photos
import UIKit

protocol PhotosServiceProtocol
{
    func allLocalPhotos(_ completion: @escaping (Result<[Photo], PhotosServiceError>)->Void)
}

enum PhotosServiceError: Error
{
    case noAccess
}

class PhotosService
    : NSObject
    , PhotosServiceProtocol
    , PHPhotoLibraryChangeObserver
{
    private let photoLibrary: PHPhotoLibrary
    private let imageManager: PHImageManager

    // MARK: public -

    override init()
    {
        self.photoLibrary = PHPhotoLibrary.shared()
        self.imageManager = PHImageManager.default()
        super.init()
        self.photoLibrary.register(self)
    }

    func allLocalPhotos(_ completion:
        @escaping (Result<[Photo], PhotosServiceError>)->Void)
    {
        requestAuthorization { result in
            switch result
            {
            case .success(_):
                let allPhotos = self.fetchAllLocalPhotos()
                completion(.success(allPhotos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: private -

    private func fetchAllLocalPhotos() -> [Photo]
    {
        let fetchOptions = PHFetchOptions()
        let allPhotos = PHAsset.fetchAssets(with: fetchOptions)
        let images = getImages(from: allPhotos)
        return images.map(Photo.init)
    }

    private func getImages(from assets: PHFetchResult<PHAsset>) -> [UIImage] {

        var images = [UIImage?]()

        for index in 0...assets.count-1
        {
            let asset = assets.object(at: index)
            requestImage(for: asset) { image in
                images.append(image)
            }
        }

        return images.compactMap { $0 }
    }

    private func requestImage(for asset: PHAsset, _ completion: @escaping (_: UIImage?)->()) {

        let option = PHImageRequestOptions()
        option.isSynchronous = true
        option.isNetworkAccessAllowed = false
        let targetSize = CGSize(width: asset.pixelWidth, height: asset.pixelWidth) // todo: ??

        imageManager.requestImage(for: asset,
                                  targetSize: targetSize,
                                  contentMode: PHImageContentMode.aspectFit,
                                  options: option)
        { (result, info) in
            print("info for asset \(asset.localIdentifier): \(info?.description ?? "No info")\n")
            if result == nil
            {
                print("Missing image for asset: \(asset.localIdentifier)")
            }
            completion(result)
        }
    }

    private func requestAuthorization(_ completion:
        @escaping (Result<Void, PhotosServiceError>)->Void)
    {
        PHPhotoLibrary.requestAuthorization { status in
            switch status
            {
            case .authorized, .limited:
                completion(.success(()))
            case .denied,
                 .restricted,
                 .notDetermined:
                completion(.failure(.noAccess))
            @unknown default:
                completion(.failure(.noAccess))
            }
        }
    }

    // MARK: PHPhotoLibraryChangeObserver -
    func photoLibraryDidChange(_ changeInstance: PHChange)
    {
        print("changes...")
    }
}

struct Photo
{
    let image: UIImage
}
