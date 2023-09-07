//
//  RecordMoreVc.swift
//  Bookjam
//
//  Created by 장준모 on 2023/09/03.
//

import UIKit
import SwiftUI

class RecordMoreVC: UIViewController {

    // MARK: Variables
    
    var tableView: UITableView = UITableView().then{
        $0.register(RecordMoreTableViewCell.self, forCellReuseIdentifier: RecordMoreTableViewCell().cellID)
    }
    
    var buttonView: UIView = UIView().then{
        $0.backgroundColor = .white
    }
    
    var independantBookStoreButton: UIButton = UIButton().then{
        $0.setTitle("독립서점", for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.setTitleColor(gray06, for: .normal)

        $0.layer.backgroundColor = gray02?.cgColor
        $0.layer.cornerRadius = 15
        $0.layer.borderColor = gray03?.cgColor
        $0.layer.borderWidth = 1
        
        $0.addTarget(self, action: #selector(didIndependentButtonTapped), for: .touchUpInside)
    }
    
    var bookPlaygroundButton: UIButton = UIButton().then{
        $0.setTitle("책놀이터", for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.setTitleColor(gray06, for: .normal)

        $0.layer.backgroundColor = gray02?.cgColor
        $0.layer.cornerRadius = 15
        $0.layer.borderColor = gray03?.cgColor
        $0.layer.borderWidth = 1
        
        $0.addTarget(self, action: #selector(didBookPlaygroundButtonTapped), for: .touchUpInside)

    }
    
    var libraryButton: UIButton = UIButton().then{
        $0.setTitle("도서관", for: .normal)
        $0.titleLabel?.font = paragraph02
        $0.setTitleColor(gray06, for: .normal)
        
        $0.layer.backgroundColor = gray02?.cgColor
        $0.layer.cornerRadius = 15
        $0.layer.borderColor = gray03?.cgColor
        $0.layer.borderWidth = 1
        
        $0.addTarget(self, action: #selector(didLibraryButtonTapped), for: .touchUpInside)

    }
    
    // MARK: viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        setUpConstraint()
        setUpDelegate()
        
        didIndependentButtonTapped()
    }
    
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = .white
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(tableView)
        view.addSubview(buttonView)
        
        [
        independantBookStoreButton,
        bookPlaygroundButton,
        libraryButton
        ].forEach{ buttonView.addSubview($0)}
        
        
    }
    
    // MARK: Delegate
    
    func setUpDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    // MARK: Constraint
    
    func setUpConstraint() {
//        independantBookStoreButton.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.width.equalTo(96)
//            $0.leading.equalToSuperview().offset(20)
//        }
//        bookPlaygroundButton.snp.makeConstraints{
//            $0.centerY.equalTo(independantBookStoreButton)
//            $0.width.equalTo(96)
//            $0.leading.equalTo(independantBookStoreButton.snp.trailing).offset(10)
//        }
//        libraryButton.snp.makeConstraints{
//            $0.centerY.equalTo(independantBookStoreButton)
//            $0.width.equalTo(82)
//            $0.leading.equalTo(bookPlaygroundButton.snp.trailing).offset(10)
//        }
//        tableView.snp.makeConstraints{
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.horizontalEdges.equalToSuperview().inset(10)
//            $0.bottom.equalToSuperview()
//            $0.height.equalTo(2000)
//        }
        
        buttonView.snp.makeConstraints{
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
                $0.leading.trailing.equalToSuperview() // Stretch the button view horizontally
                $0.height.equalTo(40) // Set the height of the button view as needed
            }
            
            independantBookStoreButton.snp.makeConstraints{
                $0.centerY.equalTo(buttonView) // Center vertically in the button view
                $0.width.equalTo(96)
                $0.leading.equalToSuperview().offset(20)
            }
            bookPlaygroundButton.snp.makeConstraints{
                $0.centerY.equalTo(buttonView) // Center vertically in the button view
                $0.width.equalTo(96)
                $0.leading.equalTo(independantBookStoreButton.snp.trailing).offset(10)
            }
            libraryButton.snp.makeConstraints{
                $0.centerY.equalTo(buttonView) // Center vertically in the button view
                $0.width.equalTo(82)
                $0.leading.equalTo(bookPlaygroundButton.snp.trailing).offset(10)
                $0.trailing.equalToSuperview().offset(-20) // Add a trailing constraint to the last button
            }

            tableView.snp.makeConstraints{
                $0.top.equalTo(buttonView.snp.bottom).offset(20)
                $0.horizontalEdges.equalToSuperview().inset(10)
                $0.bottom.equalToSuperview()
                $0.height.equalTo(2000)
            }
        
    }
    
    // MARK: Function

    @objc func didIndependentButtonTapped(){
        independantBookStoreButton.isSelected = true
        independantBookStoreButton.setTitleColor(.white, for: .selected)
        independantBookStoreButton.backgroundColor = main01
        
        bookPlaygroundButton.isSelected = false
        bookPlaygroundButton.setTitleColor(gray06, for: .normal)
        bookPlaygroundButton.backgroundColor = UIColor(cgColor: gray02?.cgColor ?? UIColor.clear.cgColor)
        
        libraryButton.isSelected = false
        libraryButton.setTitleColor(gray06, for: .normal)
        libraryButton.backgroundColor = UIColor(cgColor: gray02?.cgColor ?? UIColor.clear.cgColor)
    }
    
    @objc func didBookPlaygroundButtonTapped(){
        bookPlaygroundButton.isSelected = true
        bookPlaygroundButton.setTitleColor(.white, for: .selected)
        bookPlaygroundButton.backgroundColor = main01
        
        independantBookStoreButton.isSelected = false
        independantBookStoreButton.setTitleColor(gray06, for: .normal)
        independantBookStoreButton.backgroundColor = UIColor(cgColor: gray02?.cgColor ?? UIColor.clear.cgColor)
        
        libraryButton.isSelected = false
        libraryButton.setTitleColor(gray06, for: .normal)
        libraryButton.backgroundColor = UIColor(cgColor: gray02?.cgColor ?? UIColor.clear.cgColor)
    }
    
    @objc func didLibraryButtonTapped(){
        libraryButton.isSelected = true
        libraryButton.setTitleColor(.white, for: .selected)
        libraryButton.backgroundColor = main01
        
        independantBookStoreButton.isSelected = false
        independantBookStoreButton.setTitleColor(gray06, for: .normal)
        independantBookStoreButton.backgroundColor = UIColor(cgColor: gray02?.cgColor ?? UIColor.clear.cgColor)
        
        bookPlaygroundButton.isSelected = false
        bookPlaygroundButton.setTitleColor(gray06, for: .normal)
        bookPlaygroundButton.backgroundColor = UIColor(cgColor: gray02?.cgColor ?? UIColor.clear.cgColor)
    }

}

extension RecordMoreVC: UITableViewDelegate, UITableViewDataSource{
    
    // 섹션 수 반환
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordMoreTableViewCell().cellID, for: indexPath) as! RecordMoreTableViewCell

        return cell
    }
    
    // 섹션 당 Header 설정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        
        let headerLabel = UILabel().then{
            $0.text = "2023년 8월"
            $0.font = title06
            $0.frame = CGRect(x: 10, y: 0, width: tableView.frame.size.width - 20, height: 20) // 헤더 높이 조절 가능
        }
        
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // 섹션 푸터를 생성하고 구분 라인을 제거합니다.
        let footerView = UIView()
        footerView.backgroundColor = .clear // 배경을 투명하게 설정하면 라인이 보이지 않습니다.
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recordMoreDetailVC = RecordMoreDetailVC()
        
        navigationController?.pushViewController(recordMoreDetailVC, animated: true)
    }
    
}

//struct RecordMoreVC_Preview: PreviewProvider {
//    static var previews: some View {
//        RecordMoreVC().toPreview()
//            // .edgesIgnoringSafeArea(.all)
//    }
//}