import UIKit

extension UIView
{
    func pinEdges(to other: UIView)
    {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: other.leadingAnchor),
            trailingAnchor.constraint(equalTo: other.trailingAnchor),
            topAnchor.constraint(equalTo: other.topAnchor),
            bottomAnchor.constraint(equalTo: other.bottomAnchor)
        ])
    }

    func pinToSafeAreaEdges(to other: UIView)
    {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: other.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: other.safeAreaLayoutGuide.trailingAnchor),
            topAnchor.constraint(equalTo: other.safeAreaLayoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: other.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func center(in other: UIView)
    {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: other.centerYAnchor),
            centerXAnchor.constraint(equalTo: other.centerXAnchor)
        ])
    }
}
