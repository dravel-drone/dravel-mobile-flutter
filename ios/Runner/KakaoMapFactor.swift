//
//  KakaoMapFactor.swift
//  Runner
//
//  Created by 김준철 on 7/31/24.
//

import Foundation
import KakaoMapsSDK
import UIKit

class KakaoMapFactory : NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
        
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> any FlutterPlatformView {
        return KakaoMapPlatform(
            frame: frame,
            viewId: viewId,
            arguments: args,
            messenger: messenger)
    }
}

class KakaoMapPlatform : NSObject, FlutterPlatformView {
    private var _view: UIView
    private var kakaoMapController: KakaoMapController
    private var channel: FlutterMethodChannel
    
    init(
        frame: CGRect,
        viewId: Int64,
        arguments args: Any?,
        messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView(frame: frame)
        self.channel = FlutterMethodChannel(name: "map-kakao/\(viewId)", binaryMessenger: messenger!)
        kakaoMapController = KakaoMapController(arguments: args, channel: self.channel)
        super.init()
        _view.addSubview(kakaoMapController.view)
        kakaoMapController.view.frame = _view.bounds
        self.channel.setMethodCallHandler(handle(call:result:))
    }
    
    func handle(call:FlutterMethodCall, result:FlutterResult){
        switch call.method {
            case "moveCamera": do {
                let args = call.arguments as! [String:Any]
                let lat = args["lat"] as! Double
                let lon = args["lon"] as! Double
                let zoomLevel = args["zoomLevel"] as! Int
                do {
                    try kakaoMapController.moveCamera(lat: lat, lon: lon, zoomLevel: zoomLevel)
                } catch {
                    result(FlutterError(
                        code: "100",
                        message: "METHOD ERROR",
                        details: "moveCamera error occur"))
                }
                result(nil)
            }
            case "addSpotLabel": do {
                let args = call.arguments as! [String:Any]
                let lat = args["lat"] as! Double
                let lon = args["lon"] as! Double
                let name = args["name"] as! String
                let id = args["id"] as! Int
                do {
                    try kakaoMapController.addSpotLabel(name: name, lat: lat, lon: lon, id: id)
                } catch {
                    result(FlutterError(
                        code: "110",
                        message: "METHOD ERROR",
                        details: "add spot label error occur"))
                }
                result(nil)
            }
            default:
                result(FlutterError(
                    code: "50",
                    message: "METHOD ERROR",
                    details: "method not exist"))
        }
    }

    func view() -> UIView {
        return _view
    }
}

class KakaoMapController : UIViewController, MapControllerDelegate {
    var mapContainer: KMViewContainer?
    var mapController: KMController?
    var channel: FlutterMethodChannel?
    var _observerAdded: Bool
    var _auth: Bool
    var _appear: Bool
    var _args: [String:Any]?
    
    required init?(coder aDecoder: NSCoder) {
        _observerAdded = false
        _auth = false
        _appear = false
        super.init(coder: aDecoder)
    }
    
    init(
        arguments args: Any?,
        channel: FlutterMethodChannel
    ) {
        _args = args as? [String:Any]
        _observerAdded = false
        _auth = false
        _appear = false
        self.channel = channel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        mapController?.pauseEngine()
        mapController?.resetEngine()
        
        print("deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
//        mapContainer = self.view as? KMViewContainer
        mapContainer = KMViewContainer(frame: self.view.bounds)
        mapContainer?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(mapContainer!)
        
        //KMController 생성.
        mapController = KMController(viewContainer: mapContainer!)
        mapController!.delegate = self
        
        addObservers()
        _appear = true
        if mapController?.isEnginePrepared == false {
            mapController?.prepareEngine()
        }
        
        if mapController?.isEngineActive == false {
            mapController?.activateEngine()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
//        addObservers()
        print("viewWillAppear")
        _appear = true
        if mapController?.isEnginePrepared == false {
            mapController?.prepareEngine()
        }
        
        if mapController?.isEngineActive == false {
            mapController?.activateEngine()
        }
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        _appear = false
        mapController?.pauseEngine()  //렌더링 중지.
    }

//    override func viewDidDisappear(_ animated: Bool) {
//        removeObservers()
//        mapController?.resetEngine()     //엔진 정지. 추가되었던 ViewBase들이 삭제된다.
//    }
    
    func viewWillDestroyed(_ view: ViewBase) {
        print("viewWillDestroy")
        removeObservers()
        mapController?.resetEngine()     //엔진 정지. 추가되었던 ViewBase들이 삭제된다.
    }
    
    // 인증 성공시 delegate 호출.
    func authenticationSucceeded() {
        // 일반적으로 내부적으로 인증과정 진행하여 성공한 경우 별도의 작업은 필요하지 않으나,
        // 네트워크 실패와 같은 이슈로 인증실패하여 인증을 재시도한 경우, 성공한 후 정지된 엔진을 다시 시작할 수 있다.
        if _auth == false {
            _auth = true
        }
        
        if _appear && mapController?.isEngineActive == false {
            mapController?.activateEngine()
        }
    }
    
    // 인증 실패시 호출.
    func authenticationFailed(_ errorCode: Int, desc: String) {
        print("error code: \(errorCode)")
        print("desc: \(desc)")
        _auth = false
        switch errorCode {
        case 400:
            showToast(self.view, message: "지도 종료(API인증 파라미터 오류)")
            break;
        case 401:
            showToast(self.view, message: "지도 종료(API인증 키 오류)")
            break;
        case 403:
            showToast(self.view, message: "지도 종료(API인증 권한 오류)")
            break;
        case 429:
            showToast(self.view, message: "지도 종료(API 사용쿼터 초과)")
            break;
        case 499:
            showToast(self.view, message: "지도 종료(네트워크 오류) 5초 후 재시도..")
            
            // 인증 실패 delegate 호출 이후 5초뒤에 재인증 시도..
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                print("retry auth...")
                
                self.mapController?.prepareEngine()
            }
            break;
        default:
            break;
        }
    }
    
    func addViews() {
        //여기에서 그릴 View(KakaoMap, Roadview)들을 추가한다.
        let defaultPosition: MapPoint = MapPoint(
            longitude: _args!["lon"] as! Double,
            latitude: _args!["lat"] as! Double
        )
        //지도(KakaoMap)를 그리기 위한 viewInfo를 생성
        let mapviewInfo: MapviewInfo = MapviewInfo(
            viewName: "mapview",
            viewInfoName: "map",
            defaultPosition: defaultPosition,
            defaultLevel: _args!["zoomLevel"] as! Int)
        
        //KakaoMap 추가.
        mapController?.addView(mapviewInfo)
        print("view added")
    }
    
    func viewInit(viewName: String) {
        let mapView: KakaoMap? = mapController?.getView("mapview") as? KakaoMap
        let labelManager: LabelManager = mapView!.getLabelManager()
        let layerOption = LabelLayerOptions(layerID: "SpotLayer", competitionType: .none, competitionUnit: .symbolFirst, orderType: .rank, zOrder: 5000)
        let _ = labelManager.addLabelLayer(option: layerOption)
        
        // PoiBadge는 스타일에도 추가될 수 있다. 이렇게 추가된 Badge는 해당 스타일이 적용될 때 함께 그려진다.
        let iconStyle1 = PoiIconStyle(symbol: UIImage(named: "spot_pin_48"))
    
        // text Style 지정
        let textStyle = TextStyle(fontSize: 20, fontColor: UIColor.black)

        // PoiTextStyle 생성
        let textStyle1 = PoiTextStyle(textLineStyles: [
            PoiTextLineStyle(textStyle: textStyle)
        ])
        
        let poiStyle = PoiStyle(styleID: "SpotStyle", styles: [
            PerLevelPoiStyle(iconStyle: iconStyle1, textStyle: textStyle1, level: 14),
//            PerLevelPoiStyle(iconStyle: iconStyle2, textStyle: textStyle2, level: 12)
        ])
        labelManager.addPoiStyle(poiStyle)
        
        let initData = _args!["initData"] as? [[String: Any]] ?? []
        for data in initData {
            let location = data["location"] as! [String:Double]
            do {
                try addSpotLabel(
                    name: data["name"] as! String,
                    lat: location["lat"]!,
                    lon: location["lon"]!,
                    id: data["id"] as! Int)
            } catch {
                
            }
        }
        print("initView")
    }
    
    //addView 성공 이벤트 delegate. 추가적으로 수행할 작업을 진행한다.
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        let view = mapController?.getView("mapview") as! KakaoMap
        view.viewRect = mapContainer!.bounds    //뷰 add 도중에 resize 이벤트가 발생한 경우 이벤트를 받지 못했을 수 있음. 원하는 뷰 사이즈로 재조정.
        viewInit(viewName: viewName)
    }
    
    //addView 실패 이벤트 delegate. 실패에 대한 오류 처리를 진행한다.
    func addViewFailed(_ viewName: String, viewInfoName: String) {
        print("Failed")
    }
    
    //Container 뷰가 리사이즈 되었을때 호출된다. 변경된 크기에 맞게 ViewBase들의 크기를 조절할 필요가 있는 경우 여기에서 수행한다.
    func containerDidResized(_ size: CGSize) {
        let mapView: KakaoMap? = mapController?.getView("mapview") as? KakaoMap
        mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)   //지도뷰의 크기를 리사이즈된 크기로 지정한다.
    }
       
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    
        _observerAdded = true
    }
     
    func removeObservers(){
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)

        _observerAdded = false
    }

    @objc func willResignActive(){
        mapController?.pauseEngine()  //뷰가 inactive 상태로 전환되는 경우 렌더링 중인 경우 렌더링을 중단.
    }

    @objc func didBecomeActive(){
        mapController?.activateEngine() //뷰가 active 상태가 되면 렌더링 시작. 엔진은 미리 시작된 상태여야 함.
    }
    
    
    func moveCamera(
        lat: Double,
        lon: Double,
        zoomLevel: Int
    ) throws {
        let mapView: KakaoMap? = mapController?.getView("mapview") as? KakaoMap
        let camera = CameraUpdate.make(cameraPosition: CameraPosition(
            target: MapPoint(longitude: lon, latitude: lat),
            zoomLevel: zoomLevel,
            rotation: 0,
            tilt: 0
        ))
        mapView?.moveCamera(camera)
    }
    
    func addSpotLabel(
        name: String,
        lat: Double,
        lon: Double,
        id: Int
    ) throws {
        let mapView: KakaoMap? = mapController?.getView("mapview") as? KakaoMap
        let manager = mapView!.getLabelManager()
        let layer = manager.getLabelLayer(layerID: "SpotLayer")
        
        let poiOption = PoiOptions(styleID: "SpotStyle", poiID: "\(id)")
        poiOption.rank = 0
        poiOption.clickable = true
        
        poiOption.addText(PoiText(text: name, styleIndex: 0))
        let poi1 = layer?.addPoi(option: poiOption, at: MapPoint(longitude: lon, latitude: lat))
        poi1?.addPoiTappedEventHandler(target: self, handler: KakaoMapController.poiTappedHandler)
        poi1?.show()
    }
    
    func poiTappedHandler(_ param: PoiInteractionEventParam) {
        let poiId = param.poiItem.itemID
        debugPrint("poiId : \(poiId)")
        
        var data: [String: Int] = [:]
        data["id"] = Int(poiId)
        channel?.invokeMethod("onLabelTabbed", arguments: data)
    }
    
    func showToast(_ view: UIView, message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = NSTextAlignment.center;
        view.addSubview(toastLabel)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        
        UIView.animate(withDuration: 0.4,
                       delay: duration - 0.4,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {
                                        toastLabel.alpha = 0.0
                                    },
                       completion: { (finished) in
                                        toastLabel.removeFromSuperview()
                                    })
    }
}
