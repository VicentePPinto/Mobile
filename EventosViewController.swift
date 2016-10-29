//
//  EventosViewController.swift
//  Eventos
//
//  Created by iossenac on 08/10/16.
//  Copyright © 2016 vicente. All rights reserved.
//

import UIKit
import CoreData
class EventosViewController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 requestFetchedResultsController()
        // Do any additional setup after loading the view.
    }
    // MARK: - CoreDataTableViewController FetchedResultsController setup
    
    private func requestFetchedResultsController() {
        let request = NSFetchRequest<NSManagedObject>(entityName: "Evento")
        request.sortDescriptors = [ NSSortDescriptor(key: "nome", ascending: true) ]
        
        if let context = managedObjectContext {
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        } else {
            fetchedResultsController = nil
        }
    }
    // MARK: - UITableView data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let evento = fetchedResultsController?.object(at: indexPath) as? Evento {
            cell.textLabel?.text = evento.nome
            cell.detailTextLabel?.text = evento.cliente
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let evento = fetchedResultsController?.object(at: indexPath) as? Evento {
            managedObjectContext?.delete(evento)
            do {
                try managedObjectContext?.save()
            } catch let error {
                print("\(error)")
            }
        }
    

    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("segue \(segue.identifier )")
        if segue.identifier == "showEvento" {
            if let destination = segue.destination as? ShowEventoViewController {
                destination.managedObjectContext = managedObjectContext
                if let indexPath = tableView.indexPathForSelectedRow, let evento = fetchedResultsController?.object(at: indexPath) as? Evento {
                    destination.evento = evento
                }
                
            }
        } else {
            if let destination = segue.destination as? DetalheEventoController {
                destination.managedObjectContext = managedObjectContext
                destination.evento = nil
            }
        }
            
        
  }

}
