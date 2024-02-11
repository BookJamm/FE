//
//  MyPageListCellType.swift
//  BookJam
//
//  Created by 박민서 on 2/11/24.
//

/// 마이 페이지의 선택 목록들의 enum입니다.
enum MyPageListCellType {
    
    // --- 나의 독서생활 ---
    /// 활동 참여 현황
    case participatedActivityStatus
    /// 찜한 활동
    case markedActivities
    
    // --- 나의 정보 ---
    /// 프로필 / 닉네임 변경
    case changeProfileOrNickname
    /// 비밀번호 변경
    case changePassword
    /// 알림 설정
    case changeNotificationSetting
    
    // --- 계정 관리 ---
    /// 회원 문의
    case userInquiry
    /// 로그아웃
    case logout
    /// 회원탈퇴
    case accountTermination
}
