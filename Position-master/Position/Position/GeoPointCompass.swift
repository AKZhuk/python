import Foundation
import CoreLocation
import UIKit

class GeoPointCompass : NSObject, CLLocationManagerDelegate {
    
    private(set) var locationManager:CLLocationManager
    var arrowImageView: UIImageView?
    private var angle: Float = 0
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = 1
        }

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        let toPoint = CLLocationCoordinate2D(latitude: CLLocationDegrees(53.8729), longitude: CLLocationDegrees(27.5714))
        self.angle = calculateDistance(toPoint, userLocation: location!)
        print("\(calculateDistance(toPoint, userLocation: location!))")
    }
    
    private func degreesToRadians(degrees: Float) -> Float {
        return degrees * Float(M_PI) / 180
    }
    
    private func RadiansToDegrees(radians: Float) -> Float {
        return radians * 180 / Float(M_PI)
    }
    
    
    private func calculateDistance(targetLocation: CLLocationCoordinate2D , userLocation: CLLocation) -> Float {
        
        let userLocationLatitude: Float = Float(userLocation.coordinate.latitude)
        let userLocationLongitude: Float = Float(userLocation.coordinate.longitude)
        
        let targetedPointLatitude: Float = Float(targetLocation.latitude)
        let targetedPointLongitude: Float = Float(targetLocation.longitude)
        
        let degreeOfLatitude: Float = 111.11
        let userHeight : Float = userLocationLatitude*degreeOfLatitude
        let targetedHeight : Float = targetedPointLatitude*degreeOfLatitude
        let HeightBetweenDots : Float = userHeight - targetedHeight
        
        let degreeOfLongitude = 65.544
        let sumOfDegrees: Float = userLocationLongitude-targetedPointLongitude
        let widthBetweenDots : Float = sumOfDegrees*Float(degreeOfLongitude)
        let distance : Float = sqrt((powf(HeightBetweenDots, 2.0))*(powf(widthBetweenDots , 2.0)))
        print("Дистанция до цели \(distance) км")
        var angle : Float = atan(HeightBetweenDots/widthBetweenDots)
        let tang : Float = tan(HeightBetweenDots/widthBetweenDots)
        if (!(tang.isSignMinus)) {
            if (HeightBetweenDots.isSignMinus){ angle = -(Float(M_PI/2) - angle)}
            else {angle = Float(M_PI) - angle}}
        else {if (!(HeightBetweenDots.isSignMinus)){ angle = -(angle + Float(M_PI/2))}}
        return angle
    }
    private func SumMinusOrPlus (uHeight : Float , tHeight :Float) -> Float {
        let sum: Float
        if (uHeight.isSignMinus == true || tHeight.isSignMinus){sum = abs(uHeight)+abs(tHeight)}
        else {sum = abs(uHeight-tHeight)}
        return sum
    }
        
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Erros: \(error.localizedDescription)")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("locationManager didChangeAuthorizationStatus")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        var direction: Float = Float(newHeading.magneticHeading)
        
        if direction > 180 {
            direction = 360 - direction
        }
        else {
            direction = 0 - direction
        }

        if let arrowImageView = self.arrowImageView {
            UIView.animateWithDuration(2, animations: { () -> Void in
                arrowImageView.transform = CGAffineTransformMakeRotation(CGFloat(self.degreesToRadians(direction)+self.angle))
                
            })
        }
    }
    
}
