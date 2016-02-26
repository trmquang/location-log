//
//  MapDetailViewController.swift
//  Location Log
//
//  Created by Quang Minh Trinh on 2/25/16.
//  Copyright © 2016 Quang Minh Trinh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapDetailViewController: UIViewController, MKMapViewDelegate {
    // MARK: - Properties
    var log: Log?
    
    @IBOutlet weak var mapView: MKMapView!
    var routeLine: MKPolyline!
    var routeLineView: MKPolylineView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMapView()
        drawPolyline()
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SaveNewLog" {
            let logListTableViewController = segue.destinationViewController as! LogListTableViewController
            logListTableViewController.newLog = log
        }
    }
    
    // MARK: - Map View delegate
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay:overlay)
            lineView.strokeColor = UIColor.redColor()
            lineView.lineWidth = 4.0
            lineView.fillColor = UIColor.redColor()
            return lineView
        }
        return nil
    }
    
    // MARK: - Map View and Polyline setup
    /** Setup mapView */
    func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        var region: MKCoordinateRegion = MKCoordinateRegion()
        region.center = (log?.locationArray[0].coordinate)!
        region.span = MKCoordinateSpanMake(0.001, 0.001)
        mapView.setRegion(region, animated: true)
    }
    
    /** Setup Polyline */
    func drawPolyline() {
        let coordinates = log?.getArrayCoordinate2D()
        let coordinateBuffer = UnsafeMutablePointer<CLLocationCoordinate2D>(coordinates!)
        self.routeLine = MKPolyline(coordinates: coordinateBuffer, count: (log?.locationArray.count)!)
        mapView.addOverlay(self.routeLine)
    }
}
