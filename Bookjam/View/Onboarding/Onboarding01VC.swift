//
//  LoginViewController.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/07/09.
//

import AuthenticationServices
import SwiftUI
import UIKit

import Alamofire
import SnapKit
import Then
import KakaoSDKUser

class Onboarding01VC: UIViewController {
    
    
    // MARK: Variables
    
    let logoImage = UIImageView().then {
        $0.image = UIImage(named: "BookJamLogo")
    }
    
    let emailButton: UIButton = UIButton().then {
        $0.backgroundColor = UIColor.white
        $0.setTitle("북잼 로그인", for: .normal)
        $0.setTitleColor(main01, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.layer.cornerRadius = 8
    }
    
    let kakaoButton: UIButton = UIButton().then {
        $0.backgroundColor = UIColor(named: "KakaoColor")
        $0.setImage(UIImage(named: "KakaoLogo"), for: .normal)
        $0.setTitle(" 카카오 계정 연동하기", for: .normal)
        $0.setTitleColor(UIColor(hexCode: "191919"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(didKakaoButtonTapped), for: .touchUpInside)
    }
    
    let signUpButton: UIButton = UIButton().then {
        $0.backgroundColor = main01
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.white.cgColor
        $0.addTarget(self, action: #selector(didSignUpButtonTapped), for: .touchUpInside)
    }
    
    let appleButton: ASAuthorizationAppleIDButton = ASAuthorizationAppleIDButton().then {
        $0.layer.cornerRadius = 0
        $0.addTarget(self, action: #selector(didAppleButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpLayout()
        setUpConstraint()
    }
    
    
    // MARK: View
    
    func setUpView() {
        view.backgroundColor = main01
    }
    
    
    // MARK: Layout
    
    func setUpLayout() {
        view.addSubview(logoImage)
        view.addSubview(signUpButton)
        view.addSubview(emailButton)
        view.addSubview(kakaoButton)
        view.addSubview(appleButton)
    }
    
    
    // MARK: Constraints
    
    func setUpConstraint() {
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.45)
        }
        
        emailButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.065)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.625)
        }
        
        signUpButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.065)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.7)
        }
        
        kakaoButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.065)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.775)
        }
        
        appleButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.065)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.85)
        }
    }
    
    
    // MARK: Functions
    
    @objc func didSignUpButtonTapped() {
        navigationController?.pushViewController(Onboarding09VC(), animated: true)
    } // end of didSignUpButtonTapped()
    
    @objc func didKakaoButtonTapped() {
        print("loginKakao() called.")
        
        // ✅ 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    // ✅ 회원가입 성공 시 oauthToken 저장가능하다
                    // _ = oauthToken
                    
                    // ✅ 사용자정보를 성공적으로 가져오면 화면전환 한다.
//                    self.getUserInfo()
                }
            }
        }
        // ✅ 카카오톡 미설치
        else {
            print("카카오톡 미설치")
        }
    }
    
}//end of Onboarding01VC

// MARK: Extension

extension Onboarding01VC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    @objc func didAppleButtonTapped() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
          let request = appleIDProvider.createRequest()
          request.requestedScopes = [.fullName, .email]
            
          let authorizationController = ASAuthorizationController(authorizationRequests: [request])
          authorizationController.delegate = self
          authorizationController.presentationContextProvider = self
          authorizationController.performRequests()
    } // end of didAppleButtonTapped()
    
    // 애플 인증 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        print("Apple ID Credential Authorization User ID : \(appleIDCredential.user)")
        
        // 일단 화면 전환만 가능하게 설정
        navigationController?.pushViewController(Onboarding05VC(), animated: true)
        
        // TODO: 서버랑 연결해서 정보 넘기고 메인으로 전환까지 진행
        // 회원이면 로그인 처리하고 메인으로 전환
        // 회원 아니면 온보딩 04로 연결해서 가입 진행
    }
    
    // 애플 인증 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple ID Credential failed with error : \(error.localizedDescription)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

struct Onboarding01VC_Preview: PreviewProvider {
    static var previews: some View {
        Onboarding01VC().toPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
