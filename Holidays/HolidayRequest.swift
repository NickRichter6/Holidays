//
//  HolidayRequest.swift
//  Holidays
//
//  Created by Nick Ivanov on 01.06.2020.
//  Copyright © 2020 Nick Ivanov. All rights reserved.
//

import Foundation

enum HolidayError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct HolidayRequest {
    let resourseURL: URL
    let API_KEY = "0400dba3b6578f697a02e9b159c6c09b682d9885"
    
    init(country:String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourseString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(country)&year=\(currentYear)"
        
        guard let resourseURL = URL(string: resourseString) else {fatalError()}
        self.resourseURL = resourseURL
    }
    
    func getHolidays(completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourseURL) {data, response, error in
            guard let jsonData = data else {completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}

