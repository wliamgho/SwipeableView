//
//  StatusModel.swift
//  SwipeableView
//
//  Created by William on 22/09/19.
//  Copyright © 2019 William. All rights reserved.
//

import Foundation

struct PackageModel: Codable {
  let label: String
  let color: String
}

struct StatusModel: Codable {
  let id: String
  let status: String
  let trackingNumber: String?
  let fullName: String
  let productImage: String
  let package: PackageModel
  let estimatedDelivery: String?
  let totalPrice: Double
  let currency: String
  let updatedAt: String

  enum CodingKeys: String, CodingKey {
    case id
    case status
    case trackingNumber = "tracking_number"
    case fullName = "full_name"
    case productImage = "product_image"
    case package
    case estimatedDelivery = "estimated_delivery"
    case totalPrice = "total_price"
    case currency
    case updatedAt = "updated_at"
  }
}
