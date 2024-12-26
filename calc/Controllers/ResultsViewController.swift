//
//  ResultsController.swift
//  calc
//
//  Created by Felipe Santos on 22/12/24.
//

import UIKit
import CoreData

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var calculations: [OperationModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchResults()
    }

    func fetchResults() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<OperationModel> = OperationModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]

        do {
            calculations = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Erro ao buscar dados: \(error), \(error.userInfo)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let calculation = calculations[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short

        cell.textLabel?.text = "\(calculation.value1) \(calculation.operation ?? "?") \(calculation.value2) = \(calculation.result)"
        cell.detailTextLabel?.text = "Calculado em \(formatter.string(from: calculation.timestamp ?? Date()))"
        
        return cell
    }
}
