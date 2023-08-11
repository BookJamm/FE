//
//  BookStoreDetailHomeView.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/30.
//

// MARK: - 디테일 페이지에 표시되는 홈 탭

import SwiftUI
import UIKit

import SnapKit
import Then


class BookStoreDetailHomeView: UIView {

    // MARK: Variables
    
    var bookstoreName = String()

    // 대표 소식에 할당할 데이터 변수 News 타입으로 선언
    var news = News(storePhoto: "", title: "", content: "", date: "", photo: "")
    
    // 책 목록에 할당할 데이터 변수 Book 배열로 선언
    var books = [Book]()
    
    // 리뷰 목록에 들어갈 데이터 변수 Review 배열로 선언
    var reviews = [Review]()
    
    // 독서 활동 참여 목록에 들어갈 데이터 변수 Activity 배열로 선언
    var activities = [Activity]()
    
    var contentView: UIView = UIView().then {
        $0.backgroundColor = gray02
    }
    
    var newsView: UIView = UIView().then {
        $0.backgroundColor = .white
    }

    var newsLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
    }

    var newsMoreButton: UIButton = UIButton().then {
        $0.setTitle("더 보기", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = paragraph06
        $0.addTarget(self, action: #selector(didNewsTapped), for: .touchUpInside)
    }
    
    var newsPreview: UIView = UIView().then {
        $0.backgroundColor = main05
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    var newsPhoto: UIImageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
    
    var newsTitle: UILabel = UILabel().then {
        $0.font = paragraph02
        $0.textColor = .black
    }
    
    var newsContent: UILabel = UILabel().then {
        $0.font = paragraph06
        $0.textColor = .black
    }
    
    var newsDate: UILabel = UILabel().then {
        $0.font = captionText02
        $0.textColor = .black
    }
    
    var bookListView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var bookListLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "책 목록"
        $0.sizeToFit()
    }
    
    var bookListMoreButton: UIButton = UIButton().then {
        $0.setTitle("더 보기", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = paragraph06
        $0.addTarget(self, action: #selector(didBookListTapped), for: .touchUpInside)
    }
    
    var bookListCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 5
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(BookListCollectionViewCell.self, forCellWithReuseIdentifier: BookListCollectionViewCell.cellID)
    }
    
    var bookActivityView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var bookActivityLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "독서 활동 참여 목록"
    }
    
    var bookActivityCountLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = main03
        $0.text = "1"
    }
    
    var bookActivityMoreButton: UIButton = UIButton().then {
        $0.setTitle("더 보기", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = paragraph06
        $0.addTarget(self, action: #selector(didBookActivityTapped), for: .touchUpInside)
    }
    
    var bookActivityCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 5
    }).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(BookActivityCollectionViewCell.self, forCellWithReuseIdentifier: BookActivityCollectionViewCell.cellID)
    }
    
    var reviewView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var reviewLabel: UILabel = UILabel().then {
        $0.font = title06
        $0.textColor = .black
        $0.text = "리뷰"
    }
    
    var reviewMoreButton: UIButton = UIButton().then {
        $0.setTitle("더 보기", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = paragraph06
        $0.addTarget(self, action: #selector(didReviewTapped), for: .touchUpInside)
    }
    
    var reviewTableView: UITableView = UITableView().then {
        $0.register(VisitReviewTableViewCell.self, forCellReuseIdentifier: VisitReviewTableViewCell.cellID)
        // 스크롤 중첩으로 false 처리함
        $0.isScrollEnabled = false
    }

    
    override func draw(_ rect: CGRect) {
        setUpView()
        setUpLayout()
        setUpDelegate()
        setUpConstraint()
    }
    

    // MARK: View
    
    func setUpView() {
        // TODO: 데이터 받아올 부분
        bookstoreName = "책방연희"
        news.title = "<책방 연희> 7기 종강"
        news.photo = "ChaekYeon"
        news.content = "갑자기 억수가 퍼부었던 7월의 마지막 일요일인 오늘, 『나만의 엽서북 만들기』 with <책방 연희> 7기를 마무리했습니다."
        news.date = "2023. 07. 22"
        
        // 소식 Section 업데이트
        newsLabel.text = "\(bookstoreName)의 소식"
        newsTitle.text = news.title
        newsContent.text = news.content
        newsDate.text = news.date
        newsPhoto.image = UIImage(named: news.photo)
        
        // newsContent 글자 수 일정 이상이면 2줄로 표시
        if news.content.count >= 18 { newsContent.numberOfLines = 3 }
        
        // 책 목록 Section 업데이트
        books.append(Book(title: "기후변화 시대의 사랑", author: "김기창", publisher: "민음사", content: "", photo: "chaekYeonBook1"))
        books.append(Book(title: "돈과 나의 일", author: "이원지", publisher: "독립 출판물", content: "", photo: "chaekYeonBook2"))
        books.append(Book(title: "우리는 중독을 사랑해", author: "도우리", publisher: "한겨레 출판사", content: "", photo: "tempBookImage"))
        books.append(Book(title: "우리는 중독을 사랑해", author: "도우리", publisher: "한겨레 출판사", content: "", photo: "tempBookImage"))
        
        // 리뷰 목록 Section 업데이트
        reviews.append(Review(userName: "짐깅", visitDate: "2023. 08. 06", comment: "너무 재밌고 좋았어요!", photos: ["ChaekYeonSeven", "ChaekYeonEight", "ChaekYeonNine", ""]))
        reviews.append(Review(userName: "유짐", visitDate: "2023. 08. 08", comment: "짱이예요", photos: ["squareDefaultImage", "squareDefaultImage", "squareDefaultImage", "squareDefaultImage"]))
        reviews.append(Review(userName: "유짐", visitDate: "2023. 08. 06", comment: "너무 재밌고 좋았어요!", photos: ["squareDefaultImage", "squareDefaultImage", "squareDefaultImage", "squareDefaultImage"]))
        
        // 활동 목록 Section 업데이트
        activities.append(Activity(photo: "ChaekYeonSix", name: "박정미 작가 북토크", starValue: 4.92, numOfReview: 265, description: "시골에 살아 본 적 없는 저자가 여행 가방 하나 들고 실골에 살러 간 이유와 7년 간 시골에 살며 책방을 운영하고 글을 쓰고 사진을 찍고 농사를 지으며 알게 된 것에 관한 이야기"))
        
        // 독서 활동 참여 목록 수 업데이트
        bookActivityCountLabel.text = String(activities.count)
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        [
            newsView,
            bookListView,
            bookActivityView,
            reviewView
        ].forEach { self.addSubview($0) }
        
        [
            newsLabel,
            newsMoreButton,
            newsPreview
        ].forEach { newsView.addSubview($0) }
        
        [
            newsTitle,
            newsPhoto,
            newsContent,
            newsDate
        ].forEach { newsPreview.addSubview($0) }
        
        [
            bookListLabel,
            bookListMoreButton,
            bookListCollectionView
        ].forEach { bookListView.addSubview($0) }
        
        [
            bookActivityLabel,
            bookActivityCountLabel,
            bookActivityMoreButton,
            bookActivityCollectionView
        ].forEach { bookActivityView.addSubview($0)}
        
        [
            reviewLabel,
            reviewMoreButton,
            reviewTableView
        ].forEach { reviewView.addSubview($0)}
    }
    
    
    // MARK: Delegate
    
    func setUpDelegate() {
        bookListCollectionView.delegate = self
        bookListCollectionView.dataSource = self
        
        bookActivityCollectionView.delegate = self
        bookActivityCollectionView.dataSource = self
        
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
        
        // 소식 Section
        
        newsView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(230)
        }

        newsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }

        newsMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(newsLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        newsPreview.snp.makeConstraints {
            $0.top.equalTo(newsLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(130)
        }
        
        newsPhoto.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(newsPreview.snp.height)
        }
        
        newsTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(newsPhoto.snp.trailing).offset(15)
        }
        
        newsContent.snp.makeConstraints {
            $0.top.equalTo(newsTitle.snp.bottom).offset(10)
            $0.leading.equalTo(newsPhoto.snp.trailing).offset(15)
            $0.trailing.equalTo(newsPreview.snp.trailing).offset(-5)
        }
        
        newsDate.snp.makeConstraints {
            $0.top.equalTo(newsContent.snp.bottom).offset(10)
            $0.leading.equalTo(newsPhoto.snp.trailing).offset(15)
        }
        
        // 책 목록 Section
        
        bookListView.snp.makeConstraints {
            $0.top.equalTo(newsView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(370)
        }
        
        bookListLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        bookListMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(bookListLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        bookListCollectionView.snp.makeConstraints {
            $0.top.equalTo(bookListLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        // 독서 활동 참여 목록 Section
        
        bookActivityView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(630)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(380)
        }

        bookActivityLabel.snp.makeConstraints {
            $0.top.equalTo(bookActivityView.snp.top).offset(30)
            $0.leading.equalToSuperview().offset(20)
        }

        bookActivityCountLabel.snp.makeConstraints {
            $0.top.equalTo(bookActivityLabel.snp.top)
            $0.leading.equalTo(bookActivityLabel.snp.trailing).offset(10)
        }

        bookActivityMoreButton.snp.makeConstraints {
            $0.top.equalTo(bookActivityLabel.snp.top)
            $0.trailing.equalToSuperview().offset(-20)
        }

        bookActivityCollectionView.snp.makeConstraints {
            $0.top.equalTo(bookActivityCountLabel.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(bookActivityView.snp.bottom).offset(-20)
        }
        
        // 리뷰 Section
        
        reviewView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(1030)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        reviewMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(reviewLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        reviewTableView.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    
    // MARK: Functions
    
    // 소식 더보기 버튼 눌렀을 때 실행될 메소드
    @objc func didNewsTapped() {
        // navigationController?.pushViewController(BookStoreDetailNewsView(), animated: true)
    }
    
    // 책 목록 더보기 버튼 눌렀을 때 실행될 메소드
    @objc func didBookListTapped() {
        // navigationController?.pushViewController(BookStoreDetailBookTypeView(), animated: true)
    }
    
    // 독서 활동 참여 목록 더보기 버튼 눌렀을 때 실행될 메소드
    @objc func didBookActivityTapped() {
        // navigationController?.pushViewController(BookStoreDetailJoinView(), animated: true)
    }
    
    // 리뷰 더보기 버튼 눌렀을 때 실행될 메소드
    @objc func didReviewTapped() {
        // navigationController?.pushViewController(BookStoreDetailReviewView(), animated: true)
    }
}

// 책 목록, 독서 활동 참여 목록 밑에 들어갈 CollectionView 구현을 위한 Delegate, DataSource extension
// 가로 스크롤 구현을 위해 FlowLayout extension도 추가함
extension BookStoreDetailHomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 책 목록 셀 수 초기화
        if collectionView == self.bookListCollectionView {
            return books.count
        }
        // 독서 활동 참여 목록 셀 수 초기화
        else if collectionView == self.bookActivityCollectionView {
            return activities.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // CollectionView가 여러 개라 extension 분기 나누는 거 고려해서 cell id 전부 homeViewCell로 통일
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeViewCell", for: indexPath)
        
        // 이후 collectionView가 어떤 collectionView냐에 따라 분기 나누어 줌
        // 책 목록 데이터 삽입
        if collectionView == self.bookListCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeViewCell", for: indexPath) as! BookListCollectionViewCell
            
            cell.bookImageView.image = UIImage(named: books[indexPath.row].photo)
            cell.titleLabel.text = books[indexPath.row].title
            cell.authorLabel.text = books[indexPath.row].author
            cell.publisherLabel.text = books[indexPath.row].publisher
            
            return cell
        }
        // 독서 활동 참여 목록 데이터 삽입
        else if collectionView == self.bookActivityCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeViewCell", for: indexPath) as! BookActivityCollectionViewCell
            
            cell.activityImageView.image = UIImage(named: activities[indexPath.row].photo)
            cell.titleLabel.text = activities[indexPath.row].name
            cell.ratingLabel.text = String(activities[indexPath.row].starValue)
            
            return cell
        }
        return cell
    }
    
    // 모든 셀 사이즈는 높이 150으로 통일
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.frame.height)
    }
}

// 리뷰 탭 밑에 들어갈 리뷰 목록 구현을 위한 Delegate, DataSource extension
extension BookStoreDetailHomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    // 리뷰 목록 데이터 삽입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewTableView.dequeueReusableCell(withIdentifier: "visitReviewCell", for: indexPath) as! VisitReviewTableViewCell
        
        cell.userNameLabel.text = reviews[indexPath.row].userName
        cell.userVisitDateLabel.text = reviews[indexPath.row].visitDate
        cell.commentLabel.text = reviews[indexPath.row].comment
        cell.firstImage.image = UIImage(named: reviews[indexPath.row].photos[0])
        cell.secondImage.image = UIImage(named: reviews[indexPath.row].photos[1])
        cell.thirdImage.image = UIImage(named: reviews[indexPath.row].photos[2])
        cell.fourthImage.image = UIImage(named: reviews[indexPath.row].photos[3])
        
        return cell
    }
    
    // TODO: 사진 유무 and 리뷰 길이에 따라 높이 수정해야 함
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct BookStoreDetailHomeView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let button = BookStoreDetailHomeView()
            return button
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
