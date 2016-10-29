//
//  DetalheEventoController.swift
//  Eventos
//
//  Created by iossenac on 08/10/16.
//  Copyright © 2016 vicente. All rights reserved.
//

import UIKit
import CoreData
class DetalheEventoController: UIViewController {
    weak var managedObjectContext: NSManagedObjectContext?
    
    weak var evento: Evento? {
        didSet{
            updateUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    @IBOutlet weak var nomeEvento: UITextField!
  
    @IBOutlet weak var clienteEvento: UITextField!

    @IBOutlet weak var dataEvento: UITextField!
   
    private func updateUI() {
        nomeEvento?.text = evento?.nome
        clienteEvento?.text = evento?.cliente
        dataEvento?.text = evento?.data
    }
        
    @IBAction func cancelEdit(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveEvento(_ sender: UIBarButtonItem) {
        
        // Se existe um contexto gerenciado...
        if let context = managedObjectContext {
            // ou atualiza o evento existente...
            if let event = evento {
                event.nome = nomeEvento.text
                event.cliente = clienteEvento.text
                event.data = dataEvento.text
                
              
            }
        
                else {
                // ou, se o usuario digitou um nome, cria um evento...
                if let nome = nomeEvento.text
                {
                    let cliente = clienteEvento.text
                    let data = dataEvento.text
                        let _ = Evento.createWith(nome: nome, cliente: cliente, data: data, in: context)
                }
            }
            // ao final, salva as alteracoes do documento.
            do {
                try context.save()
            } catch let error {
                print("\(error)")
            }
        }
        // retorna a tela anterior
        _ = navigationController?.popToRootViewController(animated: true)
}
}
