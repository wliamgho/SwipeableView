//
//  ListModel.swift
//  SwipeableView
//
//  Created by William on 22/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

struct Summary: Codable {
  let status: String
  let take: Int
  let skip: Int
  let totalDays: Int
  let daysLeft: Int
  
  enum CodingKeys: String, CodingKey {
    case status
    case take
    case skip
    case totalDays = "total_days"
    case daysLeft = "days_left"
  }
}

struct Product: Codable {
  let id: String
  let name: String
  let nickname: String
  let icon: String
}

struct Schedule: Codable {
  let id: String
  let date: String
  let image: String
  let products: [Product]
}

struct UserScheduleModel: Codable {
  let summary: Summary
  let schedules: [Schedule]
}
