//
//  SaveModel.swift
//  NotesApp
//
//  Created by Yuvraj Vijay Agarkar on 22/10/20.
//

import Foundation

struct loadManager {
    static var fileUrl:URL = {
        let add = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let finalUrl = add.first!
        return finalUrl.appendingPathComponent("Note.plist")
    }()
    static func save(){
        
        let encoder = PropertyListEncoder()
        do{
        let data = try encoder.encode(records)
            try data.write(to: fileUrl)
            print("Saved")
        }catch {
            print("error in saving \(error)")
        }
    }
    static func load(){
        
        
        let decoder = PropertyListDecoder()
        do{
            let data = try Data(contentsOf: fileUrl)
        records = try decoder.decode([Note].self, from: data)
        } catch {
            print("Error in loading data\(error)")
        }
    }
}
