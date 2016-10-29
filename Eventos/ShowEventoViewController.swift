//
//  ShowEventoViewController.swift
//  Eventos
//
//  Created by iossenac on 08/10/16.
//  Copyright © 2016 vicente. All rights reserved.
//

import UIKit
import CoreData
class ShowEventoViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    weak var managedObjectContext: NSManagedObjectContext?
    var convidados:Array<String>=["Vicente", "Douglas", "Alice", "Itaua", "Natan", "Manu"]
    weak var evento: Evento? {
        didSet{
            updateUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            updateUI()
    }

    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var labelCliente: UILabel!
    @IBOutlet weak var labelData: UILabel!

    private func updateUI() {
        labelNome?.text = evento?.nome
        labelCliente?.text = evento?.cliente
        labelData?.text = evento?.data
        
    }
    
    // MARK: - Navigation
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editEvento" {
            if let destination = segue.destination as? DetalheEventoController {
                destination.managedObjectContext = managedObjectContext
                destination.evento = evento

            }
        } 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return convidados.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "convidadoCell", for: indexPath)
        cell.textLabel?.text = convidados[indexPath.row]
        return cell
    }
    
}
