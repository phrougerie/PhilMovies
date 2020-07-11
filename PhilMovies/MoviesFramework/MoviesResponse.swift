//
//  MoviesResponse.swift
//  MoviesFramework
//
//  Created by Philippe ROUGERIE on 12/06/2020.
//  Copyright © 2020 Philippe ROUGERIE. All rights reserved.
//

import Foundation

public struct MoviesResponse: Codable {
    
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
}
