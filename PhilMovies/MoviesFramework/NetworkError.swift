//
//  NetworkError.swift
//  MoviesFramework
//
//  Created by Philippe ROUGERIE on 11/06/2020.
//  Copyright © 2020 Philippe ROUGERIE. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case domainError
    case decodingError
}
