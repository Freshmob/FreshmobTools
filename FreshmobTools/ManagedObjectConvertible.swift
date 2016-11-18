//
//  ManagedObjectConvertible.swift
//  FreshmobTools
//
//  Created by Rogerio de Paula Assis on 18/11/16.
//  Copyright © 2016 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import CoreData

public protocol ManagedObjectConvertible: KeyValueCodable {
    var uniquenessIdentifierKey: String { get }
    var uniquenessIdentifierValue: String { get }
    func updatedManagedObject<T: NSManagedObject>(_ managedObject: T) -> T
}
