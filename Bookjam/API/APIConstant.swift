//
//  APIConstant.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/09.
//

import Foundation


struct Constant {
    static let baseURL = "https://bookjam.shop"
    
    static let postAuthEmailCheck = "/auth/email-check"
    static let getAuthFriends = "/auth/friends"
    static let getSearchUser = "/user/search"
    static let postAuthLogin = "/auth/login"
    static let getPlaces = "/places"
    static let getPlacesSearch = "/places/search"
    static let postRecord = "/records"
    static func getPlaceId(placeId: Int) -> String {
        return "/places/\(placeId)"
    }
    static func getPlaceNewsURL(placeId: Int) -> String {
        return "\(getPlaceId(placeId: placeId))/news"
    }
    static func getPlaceBooksURL(placeId: Int) -> String {
        return "\(getPlaceId(placeId: placeId))/books"
    }
    static func getPlaceActivitiesURL(placeId: Int) -> String {
        return "\(getPlaceId(placeId: placeId))/activities"
    }
    static func getPlaceReviewsURL(placeId: Int) -> String {
        return "\(getPlaceId(placeId: placeId))/reviews"
    }
    static let getPlaceId = "/places/:placeId"
    static func postPlacesReviews(placeId: Int) -> String {
        return "/places/\(placeId)/reviews"
    }
    static func postReviewsImages(reviewId: Int) -> String {
        return "/reviews/\(reviewId)/images"
    }
    static let getUsersOutline = "/users/outline"
    static let getUsersActivities = "/users/activities"
    static let getUsersReviews = "/users/reviews"
    static func getUsersRecords(category: Int) -> String {
        return "/users/records?category=\(category)"
    }
}

