# Qibla-Swift4
This app built in swift 4. It displays Qibla direction based on user location.

## Installation
```
git clone https://github.com/taaa22/Qibla-Swift4.git
cd Qibla-Swift4/
open Qibla.xcodeproj -a xcode
```


## Calculation
```
                      𝑠𝑖𝑛(𝜆𝐿−𝜆𝑀)
tan(𝑄) = -------------------------------------
            𝑐𝑜𝑠(𝜑𝐿).𝑡𝑎𝑛(𝜑𝑀)−𝑠𝑖𝑛(𝜑𝐿).𝑐𝑜𝑠(𝜆𝐿−𝜆𝑀)
```

  * 𝜑𝑀 = Makkah (Qibla) Latitude.
  * 𝜆𝑀 = Makkah (Qibla) Longitude.
  * 𝜑𝐿 = User location Latitude.
  * 𝜆𝐿 = User location Longitude.
  
 ``` swift
  //𝜑𝑀
  let phiM = 21.4*CGFloat.pi/180.0
  //𝜆𝑀
  let lambdaM = 39.8*CGFloat.pi/180.0
  //𝜑𝐿
  let phiL = CGFloat(location.coordinate.latitude) * CGFloat.pi/180.0
  //𝜆𝐿  
  let lambdaL = CGFloat(location.coordinate.longitude) * CGFloat.pi/180.0
        
  let qiblaAngle = 180.0/CGFloat.pi * atan2(sin(lambdaM-lambdaL),cos(phiL)*tan(phiM)-sin(phiL)*cos(lambdaM-lambdaL))
 ```
