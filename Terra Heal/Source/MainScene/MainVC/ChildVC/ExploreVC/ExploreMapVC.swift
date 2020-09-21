import UIKit
import GoogleMaps
import CoreLocation


class ExploreMapVC: BaseVC {
    
    //MARK:
    //MARK: Outlets
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnCurrentLocation: FloatingRoundButton!
    var lc: LocationCenter? = nil
    var arrForMarkers: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D.init(latitude: 22.30, longitude: 70.75),
        CLLocationCoordinate2D.init(latitude: 22.32, longitude: 70.83),
        CLLocationCoordinate2D.init(latitude: 22.35, longitude: 70.81),
        CLLocationCoordinate2D.init(latitude: 22.38, longitude: 70.82)
    ]
    //MARK:
    //MARK: View life cycle
    override func viewDidLoad(){
        super.viewDidLoad();
        self.setBackground(color: .themeBackground)
        self.lc = LocationCenter()
        self.setupMapView(mapView: self.mapView)
        self.setMarkers()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews();
        setupLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(animated)
    }
    
    
    
    func  setupLayout(){
        if self.isViewAvailable() {
            self.mapView.roundCorners(corners: [.topLeft,.topRight], radius: 40.0)
        }
    }
    
    
    @IBAction func onClickBtnCurrentLocation(_ sender: Any) {
        gettingCurrentLocation()
    }
    
    func gettingCurrentLocation() {
        lc?.requestLocationOnce()
    }
    
    func animateToLocation(coordinate:CLLocationCoordinate2D) {
        CATransaction.begin()
        CATransaction.setValue(1.0, forKey: kCATransactionAnimationDuration)
        CATransaction.setCompletionBlock {
        }
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17.0, bearing: 45, viewingAngle: 0.0)
        self.mapView.animate(to: camera)
        CATransaction.commit()
    }
    
    //MARK: Location Observer
    
    override func locationUpdate(_ ntf: Notification = Common.defaultNtf) {
        if let locationDict: [String: Any]  = ntf.userInfo?["ncd"] as? [String:Any] {
            if let location = locationDict["location"]  {
                if let coordinate =  (location as?  CLLocation)?.coordinate {
                    self.animateToLocation(coordinate: coordinate)
                }
            }
        }
    }
    
    override func locationFail(_ ntf: Notification = Common.defaultNtf) {
    }
    
    func setMarkers() {
        for location in arrForMarkers {
            let marker: GMSMarker = GMSMarker.init(position: location)
            marker.icon = UIImage.init(named: "asset-how-it-work-1")?.imageWithImage(scaledToSize: CGSize.init(width: 25, height: 40))
            marker.map = self.mapView
        }
        self.mapView.focusMap(locations: self.arrForMarkers)
    }
}

extension ExploreMapVC :GMSMapViewDelegate {
    
    func setupMapView(mapView: GMSMapView) {
        mapView.delegate = self;
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false;
        mapView.padding = UIEdgeInsets.init(top: super.getTopInset(), left: 20, bottom: super.getBottomInset(), right: 20)
        mapView.applyStyle()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition){
        
    }
    
    
}
