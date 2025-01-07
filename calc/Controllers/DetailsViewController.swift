//
//  DetailsViewController.swift
//  calc
//
//  Created by Felipe Santos on 02/01/25.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var operationModel: OperationModel?

    @IBOutlet weak var v1: UILabel!
    
    
    @IBOutlet weak var op: UILabel!
    
    
    @IBOutlet weak var v2: UILabel!
    
    
    @IBOutlet weak var res: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        v1.text = operationModel?.value1 != nil ? String(operationModel!.value1) : "Sem valor"
        op.text = operationModel?.operation
        v2.text = operationModel?.value2 != nil ? String(operationModel!.value2) : "Sem valor"
        res.text = operationModel?.result != nil ? String(operationModel!.result) : "Sem valor"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
