//
//  Copyright © 2017 Dailymotion. All rights reserved.
//
import UIKit
import SafariServices
import DailymotionPlayerSDK

class VideoPlayerViewController: UIViewController {
    @IBOutlet weak var progressBar: UIProgressView!
    var video:Video = Video()
    var time:Float = 0.0
    var timer:Timer?
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet fileprivate var playerHeightConstraint: NSLayoutConstraint! {
        didSet {
            initialPlayerHeight = playerHeightConstraint.constant
        }
    }
    fileprivate var initialPlayerHeight: CGFloat!
    fileprivate var isPlayerFullscreen = false
    
    fileprivate lazy var playerViewController: DMPlayerViewController = {
        let parameters: [String: Any] = [
            "fullscreen-action": "trigger_event",
            "sharing-action": "trigger_event"
        ]
        
        let controller = DMPlayerViewController(parameters: parameters)
        controller.delegate = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayerViewController()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo.png")
        imageView.image = image
        navigationItem.titleView = imageView
        
        startVideo()   
        
    }
    
    private func startVideo(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.setProgress), userInfo: nil, repeats: true)
        playerViewController.load(videoId: video.id!, payload:nil,completion: videoDidLoad)
        //playerViewController.notifyPlayerApi(method: <#T##String#>, argument: <#T##String?#>, completion: <#T##(() -> ())?##(() -> ())?##() -> ()#>)
    }
    
    @objc func setProgress() {
        time += 0.01
        self.progressBar.progress = time.truncatingRemainder(dividingBy: 1.0)
    }
    
    private func videoDidLoad(){
        //self.timer?.invalidate()
        //self.progressBar.isHidden = true
    }
    
    private func setupPlayerViewController() {
        addChildViewController(playerViewController)
        
        let view = playerViewController.view!
        containerView.addSubview(view)
        view.usesAutolayout(true)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            view.topAnchor.constraint(equalTo: containerView.topAnchor),
            view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        isPlayerFullscreen = size.width > size.height
        playerViewController.toggleFullscreen()
        updatePlayer(height: size.height)
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        
        if parent == nil {
            // The view is being removed from the stack, so call your function here
            playerViewController.pause()
        }
    }
    
}

extension VideoPlayerViewController: DMPlayerViewControllerDelegate {
    
    func player(_ player: DMPlayerViewController, didReceiveEvent event: PlayerEvent) {
        switch event {
        case .namedEvent(let name, _) where name == "fullscreen_toggle_requested":
            toggleFullScreen()
        case .namedEvent(let name, .some(let data)) where name == "share_requested":
            guard let raw = data["shortUrl"] ?? data["url"], let url = URL(string: raw) else { return }
            share(url: url)
        default:
            break
        }
    }
    
    fileprivate func toggleFullScreen() {
        isPlayerFullscreen = !isPlayerFullscreen
        updateDeviceOrientation()
        updatePlayer(height: view.frame.size.height)
    }
    
    private func updateDeviceOrientation() {
        let orientation: UIDeviceOrientation = isPlayerFullscreen ? .landscapeLeft : .portrait
        UIDevice.current.setValue(orientation.rawValue, forKey: #keyPath(UIDevice.orientation))
    }
    
    fileprivate func updatePlayer(height: CGFloat) {
        if isPlayerFullscreen {
            playerHeightConstraint.constant = height
        } else {
            playerHeightConstraint.constant = initialPlayerHeight
        }
    }
    
    private func share(url: URL) {
        playerViewController.pause()
        let item = ShareActivityItemProvider(title: "Dailymotion", url: url)
        let shareViewController = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        shareViewController.excludedActivityTypes = [.assignToContact, .print]
        present(shareViewController, animated: true, completion: nil)
    }
    
    func player(_ player: DMPlayerViewController, openUrl url: URL) {
        let controller = SFSafariViewController(url: url)
        present(controller, animated: true, completion: nil)
    }
    
    func playerDidInitialize(_ player: DMPlayerViewController) {
    }
    
    func player(_ player: DMPlayerViewController, didFailToInitializeWithError error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
}
