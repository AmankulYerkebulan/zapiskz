
import Foundation
import MapKit
import YandexMapKit

class BranchViewModel: NSObject {
    
    //MARK: - Properties
    private var mapView         : YMKMapView?
    var didPressMarker          : (() -> ())?
    
    //MARK: - Init
    convenience init(mapView: YMKMapView) {
        self.init()
        self.mapView = mapView
    }
}

extension BranchViewModel {
    
    //MARK: - Configure
    func configure(markers: Location) {
        guard let mapView = self.mapView else { return }
        let mapObjects = mapView.mapWindow.map.mapObjects
        let point = YMKPoint(latitude: markers.markerY, longitude: markers.markerX)
        let center = YMKPoint(latitude: markers.centerY, longitude: markers.centerX)
        
        let placeMarket = mapObjects.addPlacemark(with: point)
        placeMarket.setIconWith(UIImage(named:"marker")!)
        
        let cameraPosition = YMKCameraPosition(target: center, zoom: 15, azimuth: 0, tilt: 0)
        mapView.mapWindow.map.move( with: cameraPosition, animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5), cameraCallback: nil)
        mapObjects.addTapListener(with: self)
    }
    
}

extension BranchViewModel: YMKMapObjectTapListener {
    
    //MARK: - Delegate
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        guard let _ = mapObject as? YMKPlacemarkMapObject else { return false }
        didPressMarker?()
        return true
    }
    
}
