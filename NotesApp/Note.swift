//
//  Note.swift
//  NotesApp
//
//  Created by Yuvraj Vijay Agarkar on 21/10/20.
//

import Foundation

struct Note:Codable {
    var title:String
    var body:String
    var date:String {
      return getDateAndTime()
    }
}
func getDateAndTime()->String{
    let currentDateTime = Date()

    let formatter = DateFormatter()
//    formatter.timeStyle = .medium
    formatter.dateStyle = .long

    let dateTimeString = formatter.string(from: currentDateTime)
    return dateTimeString
}

