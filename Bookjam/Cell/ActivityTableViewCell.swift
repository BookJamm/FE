//
//  ActicityTableViewCell.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/03.
//

import UIKit
import SwiftUI

import SnapKit
import Then


class ActivityTableViewCell: UITableViewCell {
    
    // MARK: Variables
    
    static let cellID =  "activityCell"
    
    var activityView: UIView = UIView().then {
        $0.backgroundColor = gray01
    }
    
    var activityImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "squareDefaultImage")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    var activityLabel: UILabel = UILabel().then {
        $0.font = paragraph01
        $0.textColor = main03
        $0.text = "행복마실 어르신 책놀이"
    }
    
    var starImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var starValueLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "4.93"
    }
    
    var numOfReviewLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "리뷰 584"
    }
    
    var descriptionLabel: UILabel = UILabel().then {
        $0.font = paragraph06
        $0.text = "북 큐레이팅 서비스입니다. 한 달 동안 정기적으로 3권의 책을 보내드립니다. 구매자의 사연과 요청에 따라 가게의 주인장이 추천하는 책을 짧은 메시지와 함께 보내드립니다."
        $0.numberOfLines = 4
    }
    
    var joinActivityButton: UIButton = UIButton().then {
        $0.setTitle("참여하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = paragraph06
        $0.layer.borderWidth = 0.7
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 20
         $0.addTarget(self, action: #selector(didJoinActivityButtonTapped), for: .touchUpInside)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16.0, left: 16, bottom: 10, right: 16))
    }
    
    // MARK: View
    
    func setUpView() {
        
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        contentView.addSubview(activityView)
        [
            activityImageView,
            activityLabel,
            starImageView,
            starValueLabel,
            numOfReviewLabel,
            descriptionLabel,
            joinActivityButton
        ].forEach { activityView.addSubview($0) }
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        activityView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        activityImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(activityView.snp.leading).offset(20)
            $0.height.equalTo(200)
            $0.width.equalToSuperview().offset(-40)
        }
        
        activityLabel.snp.makeConstraints {
            $0.top.equalTo(activityImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(activityLabel.snp.bottom).offset(20)
            $0.leading.equalTo(activityLabel.snp.leading)
        }
        
        starValueLabel.snp.makeConstraints {
            $0.top.equalTo(activityLabel.snp.bottom).offset(20)
            $0.leading.equalTo(starImageView.snp.trailing).offset(4)
        }
        
        numOfReviewLabel.snp.makeConstraints {
            $0.top.equalTo(activityLabel.snp.bottom).offset(20)
            $0.leading.equalTo(starValueLabel.snp.trailing).offset(12)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(starImageView.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        joinActivityButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        
    }
    
    
    // MARK: Functions
    
    @objc func didJoinActivityButtonTapped() {
        
    }
     
}

#if DEBUG

@available(iOS 13.0, *)
struct ActivityTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let cell = ActivityTableViewCell()
            return cell
        }
        .previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif
