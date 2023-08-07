//
//  BookStoreDetailJoinView.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/30.
//

import SwiftUI
import UIKit

import SnapKit
import Then

class BookStoreDetailActivityView: UIView {

    // MARK: Variables
    
    var activities: [Activity] = [
        Activity(photo: "ChaekYeonEight", name: "박정미 작가 북토크", starValue: 4.92, numOfReview: 265, description: "시골에 살아 본 적 없는 저자가 여행 가방 하나 들고 실골에 살러 간 이유와 7년 간 시골에 살며 책방을 운영하고 글을 쓰고 사진을 찍고 농사를 지으며 알게 된 것에 관한 이야기"),
        Activity(photo: "ChaekYeonNine", name: "책방 창업 워크숍, 나는 왜 책방인가", starValue: 3.38, numOfReview: 150, description: "책방 창업에 대한 정보와 경험을 공유하고, 책방 창업에 대한 진솔한 이야기를 나누는 자리"),
        Activity(photo: "ChaekYeonThree", name: "스마트폰으로 사진 작가되기", starValue: 4.32, numOfReview: 130, description: "1주차 - 스마트폰 카메라 이해하기\n2주차 - 실전 촬영 테크닉 및 후보정")
    ]
    
    var activityLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "n개의 참여"
    }
    
    var activityTableView: UITableView = UITableView().then {
        $0.register(ActivityTableViewCell.self, forCellReuseIdentifier: "activityCell")
    }

    override func draw(_ rect: CGRect) {
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        activityTableView.isScrollEnabled = false
        activityTableView.separatorStyle = .none
        
        activityLabel.text = "\(activities.count)개의 참여"
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            activityLabel,
            activityTableView
        ].forEach { self.addSubview($0) }
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        activityTableView.delegate = self
        activityTableView.dataSource = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        activityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        activityTableView.snp.makeConstraints {
            $0.top.equalTo(activityLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension BookStoreDetailActivityView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = activityTableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
        
        cell.activityImageView.image = UIImage(named: activities[indexPath.row].photo)
        cell.descriptionLabel.text = activities[indexPath.row].description
        cell.activityLabel.text = activities[indexPath.row].name
        cell.numOfReviewLabel.text = "리뷰 \(String(activities[indexPath.row].numOfReview))"
        cell.starValueLabel.text = String(activities[indexPath.row].starValue)
        
        cell.contentView.backgroundColor = gray02
        cell.contentView.layer.cornerRadius = 20
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 480
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct BookStoreDetailActivityView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = BookStoreDetailActivityView()
            return button
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif
