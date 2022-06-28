//
//  ColorSettingsTableViewController.swift
//  Colormind
//
//  Created by Amin  Bagheri  on 2022-06-27.
//

import UIKit

class ColorSettingsTableViewController: UITableViewController {

    
    @IBOutlet var pickerView: UIPickerView!
    let defaults = UserDefaults.standard
    var pickerViewCount = 0
    var selectedPallette: String = ""
    
    @IBOutlet var monochromeCell: UITableViewCell!
    @IBOutlet var monochromeDarkCell: UITableViewCell!
    @IBOutlet var monochromeLightCell: UITableViewCell!
    @IBOutlet var analogicCell: UITableViewCell!
    @IBOutlet var complementCell: UITableViewCell!
    @IBOutlet var analogicComplementCell: UITableViewCell!
    @IBOutlet var triadCell: UITableViewCell!
    @IBOutlet var quadCell: UITableViewCell!
    
    func resetAllCheckmarks() {
        monochromeCell.accessoryType = .none
        monochromeDarkCell.accessoryType = .none
        monochromeLightCell.accessoryType = .none
        analogicCell.accessoryType = .none
        complementCell.accessoryType = .none
        analogicComplementCell.accessoryType = .none
        triadCell.accessoryType = .none
        quadCell.accessoryType = .none
    }
    
    func resetDefaults() {
        defaults.set(false, forKey: "monochromeCell")
        defaults.set(false, forKey: "monochromeDarkCell")
        defaults.set(false, forKey: "monochromeLightCell")
        defaults.set(false, forKey: "analogicCell")
        defaults.set(false, forKey: "complementCell")
        defaults.set(false, forKey: "analogicComplementCell")
        defaults.set(false, forKey: "triadCell")
        defaults.set(false, forKey: "quadCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        if let pickerViewObject = defaults.object(forKey: "picker") as? Int {
            print("Pickerviewobject is not nil")
            // we have to minus it by one, becayse the row we are selcting is always going to be one less as machines start form 0.
            pickerViewCount = (pickerViewObject != 0) ? pickerViewObject - 1 : 0
            print("pickerViewObject: ", pickerViewObject)
        } else {
            print("picker view objct is nil")
            pickerViewCount = 0

        }
        
        
        
        pickerView.selectRow(pickerViewCount, inComponent: 0, animated: false)
        
        resetAllCheckmarks()

        // setup the checkmarks based on which one was clicked previously
        if defaults.bool(forKey: "monochromeCell") {
            monochromeCell.accessoryType = .checkmark
        } else if defaults.bool(forKey: "monochromeDarkCell") {
            monochromeDarkCell.accessoryType = .checkmark
        } else if defaults.bool(forKey: "monochromeLightCell") {
            monochromeLightCell.accessoryType = .checkmark
        } else if defaults.bool(forKey: "analogicCell") {
            analogicCell.accessoryType = .checkmark
        } else if defaults.bool(forKey: "complementCell") {
            complementCell.accessoryType = .checkmark
        } else if defaults.bool(forKey: "analogicComplementCell") {
            analogicComplementCell.accessoryType = .checkmark
        } else if defaults.bool(forKey: "triadCell") {
            triadCell.accessoryType = .checkmark
        } else if defaults.bool(forKey: "quadCell") {
            quadCell.accessoryType = .checkmark
        } else {
            monochromeCell.accessoryType = .checkmark
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            resetAllCheckmarks()
            monochromeCell.accessoryType = .checkmark
            resetDefaults()
            defaults.set(true, forKey: "monochromeCell")
            print("SELECTED PALETTE: ", selectedPallette)

        case 1:
            resetAllCheckmarks()
            monochromeDarkCell.accessoryType = .checkmark
            resetDefaults()
            defaults.set(true, forKey: "monochromeDarkCell")
            print("SELECTED PALETTE: ", selectedPallette)

        case 2:
            resetAllCheckmarks()
            monochromeLightCell.accessoryType = .checkmark
            resetDefaults()
            defaults.set(true, forKey: "monochromeLightCell")
            print("SELECTED PALETTE: ", selectedPallette)

        case 3:
            resetAllCheckmarks()
            analogicCell.accessoryType = .checkmark
            resetDefaults()
            defaults.set(true, forKey: "analogicCell")
            print("SELECTED PALETTE: ", selectedPallette)

        case 4:
            resetAllCheckmarks()
            complementCell.accessoryType = .checkmark
            resetDefaults()
            defaults.set(true, forKey: "complementCell")
            print("SELECTED PALETTE: ", selectedPallette)

        case 5:
            resetAllCheckmarks()
            analogicComplementCell.accessoryType = .checkmark
            resetDefaults()
            defaults.set(true, forKey: "analogicComplementCell")
            print("SELECTED PALETTE: ", selectedPallette)

        case 6:
            resetAllCheckmarks()
            triadCell.accessoryType = .checkmark
            resetDefaults()
            defaults.set(true, forKey: "triadCell")
            print("SELECTED PALETTE: ", selectedPallette)

        case 7:
            resetAllCheckmarks()
            quadCell.accessoryType = .checkmark
            resetDefaults()
            defaults.set(true, forKey: "quadCell")
            print("SELECTED PALETTE: ", selectedPallette)

        default:
            print("Error")
        }
    }
    
    
    
}

extension ColorSettingsTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
    
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return 100
       }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?  {
           return String(row + 1)
       }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerViewCount = pickerView.selectedRow(inComponent: component) + 1
        defaults.set(pickerViewCount, forKey: "picker")
        print("pickerViewCount: ", pickerViewCount)
    }
    
}
