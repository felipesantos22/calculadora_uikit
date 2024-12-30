//
//  ViewController.swift
//  calc
//
//  Created by Felipe Santos on 20/12/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var input1: UITextField!
    @IBOutlet weak var input2: UITextField!
    @IBOutlet weak var result: UILabel!

    @IBOutlet weak var btnSum: UIButton!
    @IBOutlet weak var btnMin: UIButton!
    @IBOutlet weak var btnMult: UIButton!
    @IBOutlet weak var btnDiv: UIButton!
    
    
    var operation: String = ""
    
    var context: NSManagedObjectContext! // Contexto do Core Data
    
   
    @IBOutlet weak var textTilte: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textTilte.layer.cornerRadius = 10
        textTilte.clipsToBounds = true
        
        result.layer.cornerRadius = 10
        result.clipsToBounds = true
        
        btnSum.layer.cornerRadius = 10
        btnSum.clipsToBounds = true
        
        btnDiv.layer.cornerRadius = 10
        btnDiv.clipsToBounds = true
        
        btnMult.layer.cornerRadius = 10
        btnMult.clipsToBounds = true
        
        btnMin.layer.cornerRadius = 10
        btnMin.clipsToBounds = true
        
        // Obtendo o contexto do Core Data
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    }

    func calculate(num1: Double, num2: Double, operation: String) -> Double? {
        switch operation {
        case "+":
            return num1 + num2
        case "-":
            return num1 - num2
        case "*":
            return num1 * num2
        case "/":
            if num2 != 0 {
                return num1 / num2
            } else {
                return nil // Divisão por zero
            }
        default:
            return nil
        }
    }

    func saveCalculation(num1: Double, num2: Double, operation: String, resultValue: Double) {
        // Criando um novo objeto no Core Data
        let operationModel = OperationModel(context: context)
        operationModel.id = UUID()
        operationModel.value1 = num1
        operationModel.value2 = num2
        operationModel.operation = operation
        operationModel.result = resultValue
        operationModel.timestamp = Date()

        // Salvando no Core Data
        do {
            try context.save()
            print("Cálculo salvo com sucesso!")
        } catch {
            print("Erro ao salvar cálculo: \(error.localizedDescription)")
        }
    }

    func calculate() {
        // Converte as entradas para Double
        let num1 = Double(input1.text ?? "") ?? 0
        let num2 = Double(input2.text ?? "") ?? 0
        
        // Chama a função de cálculo
        if let resultValue = calculate(num1: num1, num2: num2, operation: operation) {
            result.text = String(format: "%.1f", resultValue)
            
            // Salvando o cálculo no Core Data
            saveCalculation(num1: num1, num2: num2, operation: operation, resultValue: resultValue)
        } else {
            result.text = "Erro no cálculo"
        }
    }

    @IBAction func plusButtonTapped(_ sender: UIButton) {
        operation = "+"
        calculate()
    }

    @IBAction func minusButtonTapped(_ sender: UIButton) {
        operation = "-"
        calculate()
    }

    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        operation = "*"
        calculate()
    }

    @IBAction func divideButtonTapped(_ sender: UIButton) {
        operation = "/"
        calculate()
    }
}
