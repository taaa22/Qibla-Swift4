//
//  CompassViewController.swift
//  Qibla
//
//  Created by Tariq Al Sulaimani on 06/06/2018.
//  Copyright © 2018 Cinnamon. All rights reserved.
//

import UIKit
import CoreLocation

class CompassViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var angleLabel: UILabel!
    
  let locationDelegate = LocationDelegate()
  var latestLocation: CLLocation? = nil
  var yourLocationBearing: CGFloat { return latestLocation?.bearingToLocationRadian(self.yourLocation) ?? 0 }
  var yourLocation: CLLocation {
    get { return UserDefaults.standard.currentLocation }
    set { UserDefaults.standard.currentLocation = newValue }
  }
  
  let locationManager: CLLocationManager = {
    $0.requestWhenInUseAuthorization()
    $0.desiredAccuracy = kCLLocationAccuracyBest
    $0.startUpdatingLocation()
    $0.startUpdatingHeading()
    return $0
  }(CLLocationManager())
  
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    locationManager.delegate = locationDelegate
    var qiblaAngle : CGFloat = 0.0
    
    locationDelegate.errorCallback = { error in
        self.angleLabel.text = error
        self.imageView.isHidden = true
        print(error)
    }
    
    locationDelegate.locationCallback = { location in
        self.latestLocation = location
        
        let phiK = 21.4*CGFloat.pi/180.0
        let lambdaK = 39.8*CGFloat.pi/180.0
        let phi = CGFloat(location.coordinate.latitude) * CGFloat.pi/180.0
        let lambda =  CGFloat(location.coordinate.longitude) * CGFloat.pi/180.0
        qiblaAngle = 180.0/CGFloat.pi * atan2(sin(lambdaK-lambda),cos(phi)*tan(phiK)-sin(phi)*cos(lambdaK-lambda))
        self.angleLabel.text = "\(Int(qiblaAngle.rounded()))°"
        
        self.imageView.isHidden = false
    }
    
    locationDelegate.headingCallback = { newHeading in
      
      func computeNewAngle(with newAngle: CGFloat) -> CGFloat {
        let heading = self.yourLocationBearing - newAngle.degreesToRadians
        return CGFloat(heading)
      }
      
      UIView.animate(withDuration: 0.5) {
        let angle = (CGFloat.pi/180 * -(CGFloat(newHeading) - qiblaAngle))
        self.imageView.transform = CGAffineTransform(rotationAngle: angle)
      }
    }
    
  }
  
}


