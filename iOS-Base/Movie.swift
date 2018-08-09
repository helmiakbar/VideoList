//
//  Movie.swift
//  iOS-Base
//
//  Created by Helmi Akbar on 09/08/18.
//  Copyright © 2018 Lutfi Azhar. All rights reserved.
//

import Foundation

class Movie {
    
    var id: Int?
    var title : String?
    var poster_path : String?
    var release_date : String?
    var overview : String?

    init(data: [String: Any]) {
        self.id = data["id"] as? Int ?? nil
        self.title = data["title"] as? String ?? ""
        self.poster_path = data["poster_path"] as? String ?? ""
        self.release_date = data["release_date"] as? String ?? ""
        self.overview = data["overview"] as? String ?? ""
    }
}
