import UIKit

protocol Responder: AnyObject
{
    func findConformingResponder<T>() -> T?
}

extension UIResponder: Responder {

    func findConformingResponder<T>() -> T? {
        assert(Thread.isMainThread)
        return self as? T ?? next?.findConformingResponder()
    }
}
