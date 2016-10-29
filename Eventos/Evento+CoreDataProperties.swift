//
//  Evento+CoreDataProperties.swift
//  Eventos
//
//  Created by iossenac on 08/10/16.
//  Copyright © 2016 vicente. All rights reserved.
//

import Foundation
import CoreData


extension Evento {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Evento> {
        return NSFetchRequest<Evento>(entityName: "Evento");
    }

    @NSManaged public var nome: String?
    @NSManaged public var data: String?
    @NSManaged public var cliente: String?

}
