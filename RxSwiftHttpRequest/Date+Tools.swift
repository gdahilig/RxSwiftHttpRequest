//
//  Date+Tools.swift
//  RxSwiftHttpRequest
//
//  Created by Gene Dahilig on 3/23/19.
//  Copyright © 2019 Gene Dahilig. All rights reserved.
//

import UIKit

extension Date {
    func toSeconds() -> Int! {
        return Int(self.timeIntervalSince1970)
    }
    func toMillis() -> Int! {
        return Int(self.timeIntervalSince1970 * 1000)
    }
}
