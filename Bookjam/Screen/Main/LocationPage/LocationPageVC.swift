//
//  LocationPageVC.swift
//  Bookjam
//
//  Created by 박민서 on 2023/08/28.
//

// MARK: - 메인 탭바에서 내 주변 누르면 나오는 위치 기반 검색 화면

import SwiftUI
import UIKit

import SnapKit
import Then

import CoreLocation
import MapKit
import FloatingPanel


final class LocationPageVC: BaseBottomSheetController {

    // MARK: Variables
    /// 위치 관리 매니저
    private let locationManager = CLLocationManager()
    /// 지도 뷰
    private let mapView = MKMapView()
    
    /// 화면 상단 서치바
    lazy var searchBar: UISearchBar = UISearchBar().then {
        $0.placeholder = "보고 싶은 장소를 입력해주세요."
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.searchBarStyle = .minimal

        $0.layer.borderColor = main02?.cgColor
        $0.layer.borderWidth = 1
        $0.setSearchFieldBackgroundImage(UIImage(), for: .normal)
    }
    
    /// 목록뷰 상단의 탐색 버튼입니다.
    lazy var currentLocateBtn: UIButton = UIButton().then {
        
        var titleAttr = AttributedString.init("현재 위치로 탐색")
        titleAttr.font = paragraph04

        $0.configuration = .filled()
        $0.configuration?.attributedTitle = titleAttr
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.baseBackgroundColor = main03
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(moveState), name: NSNotification.Name("PanelMove") , object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegate()
        setUpView()
        setUpLayout()
        setUpConstraint()
        setUpFloatingPanel()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // loacation 업데이트 종료
        locationManager.stopUpdatingLocation()
    }
    
    @objc func moveState(_ sender: Notification) {
        switch self.fpc.state {
        case .half :
            self.fpc.move(to: .tip, animated: true)
        case .full :
            self.fpc.move(to: .half, animated: true)
        default :
           break
        }
    }
    
    func setUpFloatingPanel() {
        var BottomContent = BookStoreListViewController()
        var BottomSheetDelegateController = StoreListBottomSheetDelegateController(vc: BottomContent)
        setupBottomSheet(contentVC: BottomContent, floatingPanelDelegate: BottomSheetDelegateController)
        
        currentLocateBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.fpc.surfaceView.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
        
    }
    

    // MARK: View
    func setUpView() {
        self.view.backgroundColor = .white
        
        // 현재 위치 설정
        locationManager.requestWhenInUseAuthorization()  // 권한 확인
        locationManager.startUpdatingLocation() // 위치 업데이트
        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // 가장 높은 정확도의 위치 정보를 요청
        
        // 지도 초기화 설정
//        mapView.showsUserLocation = true    // 유저 현재 위치 보이게
        mapView.mapType = MKMapType.standard    // 일반적인 지도 스타일
        mapView.setUserTrackingMode(.follow, animated: true)    // 지도가 사용자의 위치를 따라가는 모드로 전환
        mapView.register(LocationAnnotationView.self, forAnnotationViewWithReuseIdentifier: LocationAnnotationView.identifier)  // 지도에 어노테이션 커스텀 뷰 등록
        mapView.register(LocationDataMapClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)   // 지도에 클러스터 커스텀뷰 등록
        
        
        
        /// 테스트 데이터를 갖고 핀으로 map에 붙이기
        test_locations.forEach { data in
            let pin = MKPointAnnotation()
            pin.coordinate = data.location
            pin.title = "TEST"
            mapView.addAnnotation(pin)
        }
        
        
        
    }
    
    
    // MARK: Layout
    func setUpLayout() {
        [
            mapView,
            currentLocateBtn,
            searchBar // 상단 서치바는 가려지면 안됩니다.
        ].forEach { self.view.addSubview($0)}
    }
    
    // MARK: Delegate
    func setUpDelegate() {
        locationManager.delegate = self
        mapView.delegate = self
    }
    
    
    // MARK: Constraint
    func setUpConstraint() {
        // 상단 서치바
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        // 지도 뷰
        mapView.snp.makeConstraints {
            $0.top.equalTo(self.searchBar.snp.bottom).offset(20)
            $0.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
            
}

// MARK: - LocationManagerDelgete 입니다. 위치를 갖고 오고, 이에 따른 추가 작업을 진행합니다.
extension LocationPageVC: CLLocationManagerDelegate {
    
    /// 위치가 업데이트 되었을 때 호출됩니다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // location 가져오기 성공했을 때
        if let userLocation = locations.last?.coordinate {
            // region 설정 - 1km * 1km 반경으로 설정
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 7000, longitudinalMeters: 7000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - MKMapViewDelegate 입니다. mapView에서 사용되는 annotation의 기본 내용을 설정합니다.
extension LocationPageVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
//        switch annotation {
//        case is MKUserLocation :
//            return nil
//        case is MKClusterAnnotation :
//            return mapView.dequeueReusableAnnotationView(withIdentifier: LocationDataMapClusterView.identifier, for: annotation)
//        default :
//            return mapView.dequeueReusableAnnotationView(withIdentifier: LocationAnnotationView.identifier, for: annotation)
//        }
        
        
        
        // 사용자 위치 표시는 따로 처리
        if annotation is MKUserLocation {
            return nil
        }
        
        // 클러스터 뷰인경우
        if annotation is MKClusterAnnotation {
            print("되는거 맞냐")
//            return mapView.dequeueReusableAnnotationView(withIdentifier: LocationDataMapClusterView.identifier, for: annotation)
            return LocationDataMapClusterView(annotation: annotation, reuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        }

//        return mapView.dequeueReusableAnnotationView(withIdentifier: LocationAnnotationView.identifier, for: annotation)
        
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)

            // 핀 탭하면 상세 정보 팝업
            annotationView?.canShowCallout = true
            // 팝업 정보창 오른쪽 뷰 설정
//            let infoButton = UIButton(type: .infoLight)
//            annotationView?.rightCalloutAccessoryView = infoButton
            annotationView?.pinTintColor = main03
            annotationView?.clusteringIdentifier = "test"
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
}

// MARK: - preview
struct LocationPageVC_Preview: PreviewProvider {
    static var previews: some View {
        // MARK: - UIViewControllerPreview를 사용하여 tabBarController의 index를 사용합니다
        UIViewControllerPreview {
            let tabBarController = TabBarController()
            tabBarController.selectedIndex = 1
            return tabBarController
        }
    }
}

// MARK: 테스트 데이터 모델
struct Location {
    let location: CLLocationCoordinate2D
    let isOnline: Bool
}

// MARK: 테스트 데이터
let test_locations: [Location] = [
    Location(location: CLLocationCoordinate2D(latitude: 37.54478472921202, longitude: 126.94673688998076),
             isOnline: true),
    Location(location: CLLocationCoordinate2D(latitude: 37.54439820083342, longitude: 126.948773984529),
             isOnline: false),
    Location(location: CLLocationCoordinate2D(latitude: 37.54504947320774, longitude: 126.9550424714841),
             isOnline: false),
    Location(location: CLLocationCoordinate2D(latitude: 37.54272316128486, longitude: 126.95069875049849),
             isOnline: true),
    Location(location: CLLocationCoordinate2D(latitude: 37.54580371975873, longitude: 126.9486824957686),
             isOnline: true),
    Location(location: CLLocationCoordinate2D(latitude: 37.54746336131146, longitude: 126.95301543492582),
             isOnline: false),
    Location(location: CLLocationCoordinate2D(latitude: 37.54187695023674, longitude: 126.95247580718593),
             isOnline: true),
    Location(location: CLLocationCoordinate2D(latitude: 37.540310515649004, longitude: 126.95583737028332),
             isOnline: true),
    Location(location: CLLocationCoordinate2D(latitude: 37.54111875425007, longitude: 126.94921751985316),
             isOnline: false),
    Location(location: CLLocationCoordinate2D(latitude: 37.53979090501977, longitude: 126.94666123767706),
             isOnline: true),
    Location(location: CLLocationCoordinate2D(latitude: 37.54845995224114, longitude: 126.94993678169008),
             isOnline: true)

]
