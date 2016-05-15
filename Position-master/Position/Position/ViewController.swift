import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var label: UILabel!
    var geoPointCompass: GeoPointCompass!
    override func viewDidLoad() {
        
        self.view.autoresizingMask = ([UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight])
        self.view.backgroundColor = UIColor.blueColor()
        let arrowImageView: UIImageView = UIImageView(frame: CGRectMake(100, 200, 100, 100))
        arrowImageView.image = UIImage(named: "arrow.png")
        self.view.addSubview(arrowImageView)
        arrowImageView.center = self.view.center
        geoPointCompass = GeoPointCompass()
        geoPointCompass.arrowImageView = arrowImageView
      
    }
    @IBOutlet weak var Distance: UILabel!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if CLLocationManager.locationServicesEnabled() {
            geoPointCompass.locationManager.startUpdatingLocation()
            geoPointCompass.locationManager.startUpdatingHeading()
        }
    }
   }

