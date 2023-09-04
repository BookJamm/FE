//
//  TabBarController.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/05.
//

import UIKit

// MARK: - 메인 들어가면 표시되는 탭바 컨트롤러 구현 화면

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = main03
        
        // MARK: Variables
        
        let mainVC = MainPageVC()
        mainVC.tabBarItem.title = "메인"
        mainVC.tabBarItem.image = UIImage(systemName: "house.fill")
        mainVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        let locationVC = LocationPageVC()
        locationVC.tabBarItem.title = "내 주변"
        locationVC.tabBarItem.image = UIImage(systemName: "map.fill")
        locationVC.tabBarItem.selectedImage = UIImage(systemName: "map.fill")
        
        let feedVC = FeedPageVC()
        feedVC.tabBarItem.title = "피드"
        feedVC.tabBarItem.image = UIImage(systemName: "ellipsis.message.fill")
        feedVC.tabBarItem.selectedImage = UIImage(systemName: "ellipsis.message.fill")
        
        let mypageVC = MyPageVC()
        mypageVC.tabBarItem.title = "마이"
        mypageVC.tabBarItem.image = UIImage(systemName: "person.fill")
        mypageVC.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        let titleButton = UIBarButtonItem(image: UIImage(named: "BookJamLogoMainColor"),
                                          style: .plain,
                                          target: self,
                                          action: .none)
        
        let alertButton = UIBarButtonItem(image: UIImage(systemName: "bell"),
                                          style: .plain,
                                          target: self,
                                          action: .none)
        
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                            style: .plain,
                                            target: self,
                                            action: .none)
        
        let mainNavigationController = UINavigationController(rootViewController: mainVC)
        let locationNavigationController = UINavigationController(rootViewController: locationVC)
        let feedNavigationController = UINavigationController(rootViewController: feedVC)
        let mypageNavigationController = UINavigationController(rootViewController: mypageVC)
        
        
        // MARK: Navigation Bar 커스텀
        [
            mainNavigationController,
            locationNavigationController,
            feedNavigationController,
            mypageNavigationController
        ].forEach {
            $0.navigationBar.tintColor = .black
        }
        
        [
            mainVC,
//            locationVC,
            feedVC,
            mypageVC
        ].forEach {
            $0.navigationItem.leftBarButtonItem = titleButton
            $0.navigationItem.leftBarButtonItem?.tintColor = main03
            $0.navigationItem.setRightBarButtonItems([alertButton, settingButton], animated: true)
            $0.navigationItem.rightBarButtonItems![0].tintColor = .black
            $0.navigationItem.rightBarButtonItems![1].tintColor = .black
        }
        
        // TODO: 데모데이 이후 위치 기반 페이지 개발할 때 주석 풀기
        setViewControllers([mainNavigationController,
                             locationNavigationController,
                            feedNavigationController,
                            mypageNavigationController], animated: true)
    }
}
