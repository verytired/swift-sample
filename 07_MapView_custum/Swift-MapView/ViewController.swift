//
//  ViewController.swift
//  Swift-MapView
//
//  自分の位置を取得してMapViewに表示
//
//  Created by Yutaka Sano on 2015/09/04.
//  Copyright (c) 2015年 Yutaka Sano. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

	@IBOutlet var mapView: MKMapView!
	var myLocationManager: CLLocationManager!

	override func viewDidLoad() {
		super.viewDidLoad()

		//デリゲート設定
		mapView.frame = self.view.frame
		mapView.center = self.view.center
		mapView.delegate = self

		// LocationManagerの生成.
		myLocationManager = CLLocationManager()
		// Delegateの設定.
		myLocationManager.delegate = self
		// 距離のフィルタ.
		myLocationManager.distanceFilter = 100.0
		// 精度.
		myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

		// セキュリティ認証のステータスを取得.
		let status = CLLocationManager.authorizationStatus()
		// まだ認証が得られていない場合は、認証ダイアログを表示.
		if (status == CLAuthorizationStatus.NotDetermined) {
			// まだ承認が得られていない場合は、認証ダイアログを表示.
			self.myLocationManager.requestAlwaysAuthorization();
		}

		// 位置情報の更新を開始.
		myLocationManager.startUpdatingLocation()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	// GPSから値を取得した際に呼び出されるメソッド.
	func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {

		// 配列から現在座標を取得.
		var myLocations: NSArray = locations as NSArray
		var myLastLocation: CLLocation = myLocations.lastObject as CLLocation
		var myLocation: CLLocationCoordinate2D = myLastLocation.coordinate

		// 縮尺.
		let myLatDist: CLLocationDistance = 100
		let myLonDist: CLLocationDistance = 100

		// Regionを作成.
		var myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(myLocation, myLatDist, myLonDist)
		myRegion.center = myLocation

		// MapViewに反映.
		// 表示タイプを航空写真と地図のハイブリッドに設定

		mapView.mapType = MKMapType.Standard
		//        mapView.mapType = MKMapType.Satellite
		//        mapView.mapType = MKMapType.Hybrid
		mapView.setRegion(myRegion, animated: false)


		// 円を描画する(半径100m).
		// 地図の中心の座標
		var myCircle: MKCircle = MKCircle(centerCoordinate: manager.location.coordinate, radius: CLLocationDistance(100))
		// mapViewにcircleを追加.
		mapView.addOverlay(myCircle)

		//ピンを生成
		var myAnnotation: MKPointAnnotation = MKPointAnnotation()
		myAnnotation.coordinate = manager.location.coordinate
		//ピンのタイトルの設定
		myAnnotation.title = "current"
		//ピンのサブタイトルを設定
		myAnnotation.subtitle = "your position"
		//ピンを地図上に追加
		mapView.addAnnotation(myAnnotation)

	}

	/*
	Regionが変更した時に呼び出されるメソッド.
	*/
	func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
		println("regionDidChangeAnimated")
	}

	/*
	addAnnotationした際に呼ばれるデリゲートメソッド.
	*/
	func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
		println("addAnnotation")

		let myIdentifier = "myPin"

		var myAnnotation: MKAnnotationView!

		// annotationが見つからなかったら新しくannotationを生成.
		if myAnnotation == nil {
			myAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: myIdentifier)
		}

		// 画像を選択.
		myAnnotation.image = UIImage(named: "sample")!
		myAnnotation.annotation = annotation

		return myAnnotation
	}

	/*
	addOverlayした際に呼ばれるデリゲートメソッド.
	*/
	func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
		println("addOverlay")
		// rendererを生成.
		let myCircleView: MKCircleRenderer = MKCircleRenderer(overlay: overlay)
		// 円の内部を青色で塗りつぶす.
		myCircleView.fillColor = UIColor.blueColor()
		// 円を透過させる.
		myCircleView.alpha = 0.5
		// 円周の線の太さ.
		myCircleView.lineWidth = 0.5
		return myCircleView
	}

	/*
	認証が変更された時に呼び出されるメソッド.
	*/
	func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
		switch status {
		case .AuthorizedWhenInUse:
			println("AuthorizedWhenInUse")
			break
		case .AuthorizedAlways:
			println("AuthorizedAlways")
			break
		case .Denied:
			println("Denied")
			break
		case .Restricted:
			println("Restricted")
			break
		case .NotDetermined:
			println("NotDetermined")
			break
		default:
			println("etc.")
			break
		}
	}

	//画像切り抜き
	func cropThumbnailImage(image: UIImage, w: Int, h: Int) -> UIImage {
		// リサイズ処理

		let origRef = image.CGImage;
		let origWidth = Int(CGImageGetWidth(origRef))
		let origHeight = Int(CGImageGetHeight(origRef))
		var resizeWidth: Int = 0, resizeHeight: Int = 0

		if (origWidth < origHeight) {
			resizeWidth = w
			resizeHeight = origHeight * resizeWidth / origWidth
		} else {
			resizeHeight = h
			resizeWidth = origWidth * resizeHeight / origHeight
		}

		let resizeSize = CGSizeMake(CGFloat(resizeWidth), CGFloat(resizeHeight))
		UIGraphicsBeginImageContext(resizeSize)

		image.drawInRect(CGRectMake(0, 0, CGFloat(resizeWidth), CGFloat(resizeHeight)))

		let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()

		// 切り抜き処理

		let cropRect = CGRectMake(
		CGFloat((resizeWidth - w) / 2),
				CGFloat((resizeHeight - h) / 2),
				CGFloat(w), CGFloat(h))
		let cropRef = CGImageCreateWithImageInRect(resizeImage.CGImage, cropRect)
		let cropImage = UIImage(CGImage: cropRef)

		return cropImage!
	}
}