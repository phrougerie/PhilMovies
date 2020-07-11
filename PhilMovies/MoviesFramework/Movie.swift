//
//  File.swift
//  MoviesFramework
//
//  Created by Philippe ROUGERIE on 09/06/2020.
//  Copyright © 2020 Philippe ROUGERIE. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    
    //public let original_language : String
    public let id : Int
    public let title: String
    public let overview: String
    public let popularity: Float
    public let originalTitle: String
    public let releaseDate: Date
    
}


