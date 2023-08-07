//
//  MainPageVC.swift
//  Bookjam
//
//  Created by 장준모 on 2023/07/26.
//

import UIKit
import SwiftUI

import SnapKit
import Then


class MainPageVC: UIViewController {

    // MARK: Variables

    //임시 더미데이터
    let bookStore1 = bookStoreMain(title: "책방연희",
                                   address: "서울특별시 마포구 와우산로35길 3 (서교동) 지하 1층",
                                   reviewScore: "3.75",
                                   reviewNumber: "리뷰 5",
                                   image1: "ChaekYeon",
                                   image2: "ChaekYeonTwo",
                                   image3: "ChaekYeonThree")
    
    let bookStore2 = bookStoreMain(title: "1984store",
                                   address: "서울특별시 마포구 동교로 194 (동교동, 혜원빌딩) 1층",
                                   reviewScore: "4.78",
                                   reviewNumber: "리뷰 110",
                                   image1: "1984Store",
                                   image2: "1984StoreTwo")
    let bookStore3 = bookStoreMain(title: "공상온도",
                                   address: "서울특별시 마포구 동교로23길 40 (동교동) 지하1층",
                                   reviewScore: "4.96",
                                   reviewNumber: "리뷰 98",
                                   image1: "Gongsang",
                                   image2: "GongsangTwo",
                                   image3: "GongsangThree")
    
   lazy var dummyData: [bookStoreMain] = [bookStore1, bookStore2, bookStore3]
    
    var searchBar: UISearchBar = UISearchBar().then{
        $0.placeholder = "상호명 또는 주소 검색"
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.searchBarStyle = .minimal

        $0.layer.borderColor = main02?.cgColor
        $0.layer.borderWidth = 1
        $0.setSearchFieldBackgroundImage(UIImage(), for: .normal)
    }
    
    var independentBookstoreButton: UIButton = UIButton().then{
        $0.setTitle("독립서점", for: .normal)
        $0.tintColor = main03
        $0.titleLabel?.font = paragraph02
        
        //이미지 크기 쉽게 조절
        let config = UIImage.SymbolConfiguration(
            pointSize: 30, weight: .regular, scale: .default)
        let image = UIImage(systemName: "book.fill", withConfiguration: config)
        $0.setImage(image, for: .normal)
        
        // Create the button configuration
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 20
        configuration.imagePlacement = .top
        
        // Create the button using the configuration
        $0.configuration = configuration
    }
    
    var bookPlayGroundButton: UIButton = UIButton().then{
        $0.setTitle("책 놀이터", for: .normal)
        $0.tintColor = gray05
        $0.titleLabel?.font = paragraph02
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 30, weight: .regular, scale: .default)
        let image = UIImage(systemName: "cup.and.saucer.fill", withConfiguration: config)
        $0.setImage(image, for: .normal)
        
        // Create the button configuration
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 20
        configuration.imagePlacement = .top
        
        // Create the button using the configuration

        $0.configuration = configuration
    }
    
    var libraryButton: UIButton = UIButton().then{
        $0.setTitle("도서관", for: .normal)
        $0.tintColor = gray05
        $0.titleLabel?.font = paragraph02
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 30, weight: .regular, scale: .default)
        let image = UIImage(systemName: "books.vertical.fill", withConfiguration: config)
        $0.setImage(image, for: .normal)
        
        // Create the button configuration
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 20
        configuration.imagePlacement = .top
        
        // Create the button using the configuration

        $0.configuration = configuration
    }
    
    var sortView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var lineView: UIView = UIView().then {
        $0.backgroundColor = gray04
    }
    
    var sortButton: UIButton = UIButton().then{
        $0.setTitle("거리순 ↓", for: .normal)
        $0.setTitleColor(gray05, for: .normal)
        $0.setTitle("거리순", for: .selected)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    var infoButton: UIButton = UIButton().then{
        $0.setImage(UIImage(systemName: "info.circle"), for: .normal)
        $0.tintColor = gray05
    }
    
    var tableView: UITableView = UITableView().then {
        $0.register(MainPageBookStoreTableViewCell.self, forCellReuseIdentifier: "bookStoreCell")
    }
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpLayout()
        setUpConstraint()
        setUpDelegate()
    }
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        
        // hideKeyboard 적용하면 tableViewCell 터치가 안되는 이슈가 있어서 일단 주석처리함
        // hideKeyboard()
    }

    // MARK: Layout
    
    func setUpLayout(){
        [
            searchBar,
            independentBookstoreButton,
            bookPlayGroundButton,
            libraryButton,
            tableView,
            sortView
        ].forEach {
            view.addSubview($0)
        }
        sortView.addSubview(lineView)
        sortView.addSubview(sortButton)
        sortView.addSubview(infoButton)
    }
    
    // MARK: Constraints

    func setUpConstraint(){
        searchBar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(45)
        }
        
        independentBookstoreButton.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(30)
        }
        
        bookPlayGroundButton.snp.makeConstraints {
            $0.centerY.equalTo(independentBookstoreButton)
            $0.centerX.equalToSuperview()
        }
        
        libraryButton.snp.makeConstraints {
            $0.centerY.equalTo(independentBookstoreButton)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        sortView.snp.makeConstraints {
            $0.top.equalTo(independentBookstoreButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        sortButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(20)
        }
        
        infoButton.snp.makeConstraints {
            $0.centerY.equalTo(sortButton)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(sortView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }//end of setUpConstraint
    
    // MARK: Delegate
    
    func setUpDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}//end of MainPageVC

// MARK: Extension

extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count  //임시
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookStoreCell", for: indexPath) as! MainPageBookStoreTableViewCell
        
        //임시 더미데이터 추가
        let book = dummyData[indexPath.row]
        cell.bookstoreLabel.text = book.bookStoreTitle
        cell.locationLabel.text = book.bookStoreAddress
        cell.starLabel.text = book.bookStoreReviewScore
        cell.reviewCountLabel.text = book.bookStoreReviewNumber
        
        var images: [String] = []
        if let image1 = book.image1 {
            images.append(image1)
        }
        if let image2 = book.image2 {
            images.append(image2)
        }
        if let image3 = book.image3 {
            images.append(image3)
        }
        cell.images = images
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPage = BookstoreDetailPageVC()
        
        // TODO: 데이터 넣기
        
        navigationController?.pushViewController(detailPage, animated: true)
    }
}

extension UIImage {
    // Create a UIImage with a solid color
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}

struct MainPageVC_Preview: PreviewProvider {
    static var previews: some View {
        MainPageVC().toPreview()
            //.edgesIgnoringSafeArea(.all)
    }
}
