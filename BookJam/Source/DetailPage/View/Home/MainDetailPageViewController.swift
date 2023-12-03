//
//  MainDetailPageViewController.swift
//  BookJam
//
//  Created by 장준모 on 11/10/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

//디테일 페이지 섹션 레이아웃
enum DetailSection: Hashable {
    case Home
    case Review
    case Activity
    case News(String)
    case BookList
}

//디테일 페이지 셀
enum Item: Hashable {
    case ReviewItem(PlaceIdReviewsResponseModel)
    case ActivityItem(Activities)
    case NewsItem(PlaceIdNewsResponseModel)
    case BookListItem(PlaceIdBooksResponseModel)
}

@available(iOS 16.0, *)
final class MainDetailPageViewController: UIViewController {
    
    // MARK: Variables
    private var dataSource: UICollectionViewDiffableDataSource<DetailSection, Item>?
    
    var topView = MainDetailTopView()
    
    
    lazy var tableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.register(MainDetailHomeTabTableViewCell.self, forCellReuseIdentifier: MainDetailHomeTabTableViewCell.id)
    }
    
    let segmentedControl = MainDetailSegmentedControl(items: ["홈", "소식", "참여", "리뷰", "책 종류"])
    
//    var shouldHideFirstView: Bool? {
//        didSet {
//          guard let shouldHideFirstView = self.shouldHideFirstView else { return }
//          self.collectionView.isHidden = shouldHideFirstView
//          self.newsView.isHidden = !self.collectionView.isHidden
//        }
//      }
    
//    var shouldHideFirstView: Bool = false {
//        didSet {
//            self.collectionView.isHidden = shouldHideFirstView
//            self.newsView.isHidden = !self.collectionView.isHidden
//        }
//    }
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        //        setUpLayout()
        setUpConstraint()
        setSnapShot()
        setUpDelegate()
  
    }
    
    // MARK: Constraint
    
    func setUpConstraint() {
        self.view.addSubview(topView)
        self.view.addSubview(tableView)
        self.view.addSubview(segmentedControl)
        tableView.tableHeaderView = topView
        
        topView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 450)

//        segmentedControl.snp.makeConstraints{
//            $0.width.equalToSuperview().multipliedBy(0.9)
//            $0.height.equalTo(40)
//            $0.centerX.equalToSuperview().offset(-10)
//            $0.top.equalTo(topView.snp.bottom)
//        }
        
        tableView.snp.makeConstraints{
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalToSuperview()
        }

    }
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        
    }
    
    // MARK: Delegate
    
    private func setUpDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<DetailSection, Item>()
        
    }
    

    // MARK: Function
    
    
    private func createHomeSection() -> NSCollectionLayoutSection{//홈 섹션
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(320))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    
    
    //Segmented Control 클릭 시
//    @objc private func didChangeValue(segment: UISegmentedControl) {
//        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
//      }
    
}

@available(iOS 16.0, *)
extension MainDetailPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // 소식 셀 데이터 삽입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailHomeTabTableViewCell.id, for: indexPath) as! MainDetailHomeTabTableViewCell
        
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 1000 //임시
        
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainDetailTopView.id)
//        
//        return header
//    }
    
}

import SwiftUI
@available(iOS 16.0, *)
struct MainDetailPageViewController_Preview: PreviewProvider {
    static var previews: some View {
        MainDetailPageViewController().toPreview()
            //.edgesIgnoringSafeArea(.all)
    }
}
