//
//  Evento+CoreDataClass.swift
//  Eventos
//
//  Created by iossenac on 08/10/16.
//  Copyright © 2016 vicente. All rights reserved.
//

import Foundation
import CoreData


public class Evento: NSManagedObject {
    
    
    
    class func createWith(nome: String, cliente: String?, data: String?, in context: NSManagedObjectContext) -> Evento? {
        print("\(nome)")
        let request = NSFetchRequest<Evento>(entityName: "Evento")
        let query = "nome == %@"
        let params = [ nome ]
        
        request.predicate = NSPredicate(format: query, argumentArray: params)
        
        // tenta recuperar o Evento
        if let evento = (try? context.fetch(request))?.first {
            return evento
        }
        // senao cria o Evento
        if let evento = NSEntityDescription.insertNewObject(forEntityName: "Evento", into: context) as? Evento {
            evento.nome = nome
            evento.cliente = cliente
            evento.data = data
            
            return evento
        }
        // em caso de erro...
        return nil
    }

}
