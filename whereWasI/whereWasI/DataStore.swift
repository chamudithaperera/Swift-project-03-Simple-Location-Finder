//
//  DataStore.swift
//  whereWasI
//
//  Created by Chamuditha Kavishan on 2024-06-02.
//

import Foundation

struct StorageKeys
{
    static let storedLat = "storedLat"
    static let storedLong = "storedLong"
}

class DataStore
{
    func GetDefaults () -> UserDefaults
    {
        return UserDefaults.standard
    }
    
    func StoreDataPoints (latitude: String, longitude: String)
    {
        let def = GetDefaults()
        
        def.setValue(latitude, forKey: StorageKeys.storedLat)
        def.setValue(longitude, forKey: StorageKeys.storedLong)
        
        def.synchronize()
        
        print(latitude + " : " + longitude)
    }
    
    func GetLastLocation () -> VisitedPoint?
    {
        let defaults = GetDefaults()
        
        if let lat = defaults.string(forKey: StorageKeys.storedLat)
        {
            if let long = defaults.string(forKey: StorageKeys.storedLong)
            {
                return VisitedPoint(lat: lat, long: long)
            }
        }
        
        return nil
    }
}
