//
//  BookstoreDetailVC.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/28.
//

// MARK: - 메인 페이지 책방 목록 중 하나를 클릭하면 나오는 해당 책방 디테일 페이지 화면

import SafariServices
import SwiftUI
import UIKit

import SnapKit
import Then

class BookstoreDetailPageVC: UIViewController {

    // MARK: Variables
    
    /// 디테일 페이지 가장 위에 표시되는 5개 사진 목록
    var images = ["ChaekYeon", "ChaekYeonTwo", "ChaekYeonThree", "ChaekYeonFour", "ChaekYeonFive"]
    
    var scrollView: UIScrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    
    var contentView: UIView = UIView()
    
    var photoCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 1
        $0.minimumInteritemSpacing = 1
    }).then {
        $0.backgroundColor = .white
        $0.register(BookStorePhotoCollectionViewCell.self, forCellWithReuseIdentifier: BookStorePhotoCollectionViewCell.cellID)
    }
    
    var bookstoreLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "책방연희"
        $0.sizeToFit()
    }
    
    var bookMarkImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "book.fill")
        $0.tintColor = gray04
    }
    
    var storeTypeLabel : UILabel = UILabel().then {
        $0.font = paragraph04
        $0.textColor = gray06
        $0.text = "독립서점"
        $0.sizeToFit()
    }
    
    var starImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = warning
    }
    
    var starLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "3.75"
    }
    
    var reviewCountLabel: UILabel = UILabel().then {
        $0.font = paragraph03
        $0.text = "리뷰 5"
        $0.sizeToFit()
    }
    
    var underLineView: UIView = UIView().then {
        $0.backgroundColor = gray04
    }
    
    var locationPinImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "locationPin")
        $0.tintColor = gray07
    }
    
    var clockImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "clock.fill")
        $0.tintColor = gray07
    }
    
    var locationLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = gray06
        $0.text = "서울특별시 마포구 와우산로35길 3 (서교동) 지하 1층"
    }
    
    var timeLabel: UILabel = UILabel().then {
        $0.font = paragraph05
        $0.textColor = complete
        $0.text = "영업 중"
    }
    
    var siteURL: UIButton = UIButton().then {
        $0.setTitle("https://www.instagram.com/chaegbangyeonhui/", for: .normal)
        $0.setTitleColor(main03, for: .normal)
        $0.titleLabel?.font = paragraph06
        $0.addTarget(self, action: #selector(didURLTapped), for: .touchUpInside)
    }
    
    var dividerView: UIView = UIView().then {
        $0.backgroundColor = gray02
    }
    
    /// 서점 세부 내용 전환해주는 SegmentedControl
    var segmentController: UISegmentedControl = UISegmentedControl().then {
        $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        $0.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: gray04!,
            NSAttributedString.Key.font: paragraph03
        ], for: .normal)
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: main03!,
            NSAttributedString.Key.font: paragraph03
        ], for: .selected)
        
        /// segments 삽입
        $0.insertSegment(withTitle: "홈", at: 0, animated: true)
        $0.insertSegment(withTitle: "소식", at: 1, animated: true)
        $0.insertSegment(withTitle: "참여", at: 2, animated: true)
        $0.insertSegment(withTitle: "리뷰", at: 3, animated: true)
        $0.insertSegment(withTitle: "책 종류", at: 4, animated: true)

        /// 기본 탭은 홈으로 설정
        $0.selectedSegmentIndex = 0
        
        /// 값 바뀌면 didSegmentControllerValueChanged 호출
        $0.addTarget(self, action: #selector(didSegmentControllerValueChanged), for: .valueChanged)
    }
    
    var segmentControlUnderlineView: UIView = UIView().then {
        $0.backgroundColor = gray03
    }
    
    var segmentControlSelectedUnderLineView: UIView = UIView().then {
        $0.backgroundColor = main03
    }
    
    var homeView: BookStoreDetailHomeView = BookStoreDetailHomeView().then {
        $0.backgroundColor = gray02
    }
    
    var newsView: BookStoreDetailNewsView = BookStoreDetailNewsView()
    var activityView: BookStoreDetailActivityView = BookStoreDetailActivityView()
    var bookListView: BookStoreDetailBookListView = BookStoreDetailBookListView()
    
    var reviewView: BookStoreDetailReviewView = BookStoreDetailReviewView().then {
        $0.backgroundColor = gray02
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
        setUpNotification()
    }
    

    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            photoCollectionView,
            bookstoreLabel,
            bookMarkImageView,
            storeTypeLabel,
            starImageView,
            starLabel,
            reviewCountLabel,
            underLineView,
            locationPinImageView,
            clockImageView,
            locationLabel,
            timeLabel,
            siteURL,
            dividerView,
            segmentController,
            segmentControlUnderlineView,
            segmentControlSelectedUnderLineView,
            homeView,
            newsView,
            activityView,
            reviewView,
            bookListView
        ].forEach { contentView.addSubview($0) }
        
        /// viewDidLoad()에서 homeView 제외한 4개의 탭은 숨김 처리
        [
            newsView,
            activityView,
            reviewView,
            bookListView
        ].forEach { $0.isHidden = true }
    }
    
    
    // MARK: Delegate
    
    func setUpDelegate() {
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(2000)
        }
        
        photoCollectionView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.width.equalToSuperview()
            $0.height.equalTo(200)
        }

        bookstoreLabel.snp.makeConstraints {
            $0.left.equalTo(photoCollectionView).offset(15)
            $0.bottom.equalTo(photoCollectionView).multipliedBy(1.2)
        }

        bookMarkImageView.snp.makeConstraints {
            $0.right.equalTo(bookstoreLabel).offset(30)
            $0.centerY.equalTo(bookstoreLabel)
        }

        storeTypeLabel.snp.makeConstraints {
            $0.left.equalTo(bookstoreLabel)
            $0.bottom.equalTo(bookstoreLabel).offset(30)
        }

        starImageView.snp.makeConstraints {
            $0.left.equalTo(bookstoreLabel)
            $0.bottom.equalTo(storeTypeLabel).offset(35)
        }

        starLabel.snp.makeConstraints {
            $0.left.equalTo(bookstoreLabel).offset(25)
            $0.bottom.equalTo(storeTypeLabel).offset(35)
        }

        reviewCountLabel.snp.makeConstraints {
            $0.left.equalTo(starLabel).offset(45)
            $0.bottom.equalTo(storeTypeLabel).offset(35)
        }

        underLineView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.93)
            $0.height.equalTo(1)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(starImageView).offset(20)
        }

        locationPinImageView.snp.makeConstraints {
            $0.left.equalTo(starImageView)
            $0.bottom.equalTo(underLineView).offset(40)
        }

        locationLabel.snp.makeConstraints {
            $0.left.equalTo(locationPinImageView).offset(25)
            $0.centerY.equalTo(locationPinImageView)
        }

        clockImageView.snp.makeConstraints {
            $0.centerX.equalTo(locationPinImageView)
            $0.bottom.equalTo(locationPinImageView).offset(30)
        }

        timeLabel.snp.makeConstraints {
            $0.left.equalTo(clockImageView).offset(25)
            $0.centerY.equalTo(clockImageView)
        }

        siteURL.snp.makeConstraints {
            $0.leading.equalTo(clockImageView.snp.leading).offset(5)
            $0.bottom.equalTo(clockImageView).offset(35)
        }

        dividerView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(15)
            $0.top.equalTo(siteURL.snp.bottom).offset(10)
        }

        segmentController.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview().offset(-10)
            $0.top.equalTo(dividerView.snp.bottom).offset(5)
        }

        segmentControlUnderlineView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(segmentController.snp.bottom).offset(5)
        }

        segmentControlSelectedUnderLineView.snp.makeConstraints {
            $0.width.equalTo(segmentController).dividedBy(5)
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalTo(segmentController.snp.bottom).offset(5)
        }
        
        homeView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.top.equalTo(segmentControlUnderlineView.snp.bottom)
            $0.bottom.equalToSuperview()
        }

        newsView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(segmentControlUnderlineView.snp.bottom)
            $0.bottom.equalToSuperview()
        }

        activityView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(segmentControlUnderlineView.snp.bottom)
            $0.bottom.equalToSuperview()
        }

        reviewView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(segmentControlUnderlineView.snp.bottom)
            $0.bottom.equalToSuperview()
        }

        bookListView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(segmentControlUnderlineView.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    
    // MARK: Functions
    
    /// URL 버튼 클릭되면 호출되는 메소드
    /// 주소에 맞는 SafariViewController를 present
    @objc func didURLTapped() {
        let url = NSURL(string: "https://www.instagram.com/chaegbangyeonhui/")
        let instaView: SFSafariViewController = SFSafariViewController(url: url! as URL)
        
        self.present(instaView, animated: true, completion: nil)
    }
    
    /// SegmentedControl에서 세그먼트의 값이 변경되었을 경우 호출되는 메소드
    @objc private func didSegmentControllerValueChanged() {
        let segmentIndex = CGFloat(segmentController.selectedSegmentIndex)
        let segmentWidth = segmentController.frame.width / CGFloat(segmentController.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        
        /// segmentIndex 따라서 segmentControlSelectedUnderLineView 위치 업데이트
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            guard let self = self else { return }
            self.segmentControlSelectedUnderLineView.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(10 + leadingDistance)
            }
        })
        
        /// segmentIndex 따라서 화면 전환
        /// 홈 탭
        if segmentIndex == 0 {
            homeView.isHidden = false
            [
                newsView,
                activityView,
                reviewView,
                bookListView
            ].forEach { $0.isHidden = true }
        }
        /// 소식 탭
        else if segmentIndex == 1 {
            newsView.isHidden = false
            [
                homeView,
                activityView,
                reviewView,
                bookListView
            ].forEach { $0.isHidden = true }
        }
        /// 참여 탭
        else if segmentIndex == 2 {
            activityView.isHidden = false
            [
                homeView,
                newsView,
                reviewView,
                bookListView
            ].forEach { $0.isHidden = true }
        }
        /// 리뷰 탭
        else if segmentIndex == 3 {
            reviewView.isHidden = false
            [
                homeView,
                newsView,
                activityView,
                bookListView
            ].forEach { $0.isHidden = true }
        }
        /// 책 종류 탭
        else if segmentIndex == 4 {
            bookListView.isHidden = false
            [
                homeView,
                activityView,
                reviewView,
                newsView
            ].forEach { $0.isHidden = true }
        }
    }
    
    /// 리뷰 탭에서 인증 후 리뷰 작성하기 버튼 누르면 화면 전환되도록 구현
    @objc func pushReviewDetailVC() {
        navigationController?.pushViewController(BookStoreReviewDetailVC(), animated: true)
    }
    
    /// 리뷰 작성하고 업로드 버튼 누르면 토스트 메시지 띄우도록 구현
    @objc func makeReviewUploadToast() {
        print("맛있는 토스트 굽굽")
    }
    
    // MARK: Notification
    
    func setUpNotification() {
        /// BookStoreDetailReviewView에서 리뷰 작성하기 버튼 눌렀을 때 전송되는 notification을 수신
        NotificationCenter.default.addObserver(self, selector: #selector(pushReviewDetailVC), name: NSNotification.Name("writeReviewButtonTapped"), object: nil)
        /// BookStoreWriteReviewVC에서 업로드 버튼 눌렀을 때 전송되는 notification을 수신
        NotificationCenter.default.addObserver(self, selector: #selector(makeReviewUploadToast), name: NSNotification.Name("uploadButtonTapped"), object: nil)
    }
}

/// 디테일 페이지 가장 위에 표시되는 5개 사진 목록 CollectionView 구현을 위한 Delegate, DataSource extension
/// 셀 별 사이즈 지정을 위한 DelegateFlowLayout extension 추가
extension BookstoreDetailPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookStorePhotoCollectionViewCell.cellID, for: indexPath) as! BookStorePhotoCollectionViewCell
        
        /// images 배열 photoImageView의 이미지로 할당
        cell.photoImageView.image = UIImage(named: images[indexPath.row])
        cell.photoImageView.contentMode = .scaleAspectFill
        
        return cell
    }
    
    /// 셀 별 사이즈 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// 첫번째 셀일 경우 width와 height를 모두 프레임 높이와 같게 조정
        if indexPath.row == 0 {
            return CGSize(width: photoCollectionView.frame.height - 1, height: photoCollectionView.frame.height - 1)
        }
        /// 아닐 경우 width와 height를 모두 (프레임 높이 / 2)와 같게 조정
        return CGSize(width: photoCollectionView.frame.height / 2 - 1, height: photoCollectionView.frame.height / 2 - 1)
    }
}

struct BookstoreDetailPageVC_Preview: PreviewProvider {
    static var previews: some View {
        BookstoreDetailPageVC().toPreview()
            .previewLayout(.sizeThatFits)
            // .edgesIgnoringSafeArea(.all)
    }
}
