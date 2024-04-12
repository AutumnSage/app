//
//  Item.swift
//  Outread
//
//  Created by Dhruv Sirohi on 17/1/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
