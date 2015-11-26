//
//  Observation.swift
//  Spotter
//
//  Created by Alicia Sykes on 26/11/2015.
//  Copyright © 2015 Alicia Sykes. All rights reserved.
//

import Foundation


class Observation {
    
    init(username: String, name:String, description:String, date:String,
        latitude:String, longitude:String, category:String){
        self.username = username
        self.name = name
        self.description = description
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.category = category
    }
    
    var username: String
    var name: String
    var description: String
    var date: String
    var latitude: String
    var longitude: String
    var category: String

}
