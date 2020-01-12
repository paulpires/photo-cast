import UIKit

class ViewController: UIViewController
{
    init()
    {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .red
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) not supported")
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("loaded")
    }
}

