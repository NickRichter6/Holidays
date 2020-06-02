//
//  Holiday.swift
//  Holidays
//
//  Created by Nick Ivanov on 01.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import Foundation

struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo: Decodable {
    var iso: String
}
