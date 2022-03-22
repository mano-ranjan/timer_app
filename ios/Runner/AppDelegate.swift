import UIKit
import Flutter
import CoreMotion

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, FlutterStreamHandler {
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    var runCount = 0
    
    func runTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        

        
//                  result("success")

    }
    
//    func updateTimer() {
//        seconds -= 1
//        timerLabel.text = timeString(time: TimeInterval(seconds))
//
//    }
    let motionManager = CMMotionManager()
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
                print("Timer fired!")
                runCount += 1
                events(runCount)
                //// EVENT CHANNEL CODE
                
                if runCount == 3 {
                    timer.invalidate()
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let METHOD_CHANNEL_NAME = "samples.flutter.dev/methodTimer"
    let EVENT_CHANNEL_NAME = "samples.flutter.dev/eventTimer"
    
    
    let methodChannel = FlutterMethodChannel(
        name: METHOD_CHANNEL_NAME,
        binaryMessenger: controller.binaryMessenger)
        
        let streamChannel = FlutterEventChannel(name: EVENT_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
        streamChannel.setStreamHandler(self)
        
        
        methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "getBatteryLevel":
                result(self.startTimer())
            case "startTimer":
                result(self.startTimer())
            case "pauseTimer":
                result(self.pauseTimer())
            case "stopTimer":
                result(self.stopTimer())
            default:
                result(FlutterMethodNotImplemented)
            }
        })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
//   private func receiveBatteryLevel(result: FlutterResult) {
//   let device = UIDevice.current
//   device.isBatteryMonitoringEnabled = true
//   if device.batteryState == UIDevice.BatteryState.unknown {
//     result(FlutterError(code: "UNAVAILABLE",
//                         message: "Battery info unavailable",
//                         details: nil))
//   } else {
//     result(Int(device.batteryLevel * 100))
//   }
// }
    
    private func stopTimer() -> Bool {
        return false
    }
    private func pauseTimer() -> Bool {
        return false
    }
    private func startTimer() {
      runTimer()
//      let device = UIDevice.current
//      device.isBatteryMonitoringEnabled = true;
//      if device.batteryState == UIDevice.BatteryState.unknown {
//          return -1
//      } else {
//          return Int(device.batteryLevel * 100)
//      }
}
}


