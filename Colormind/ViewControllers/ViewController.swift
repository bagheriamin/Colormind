//
//  ViewController.swift
//  Colormind
//
//  Created by Amin  Bagheri  on 2022-06-27.
//

import UIKit

class ViewController: UIViewController {
    
    override var canBecomeFirstResponder: Bool {
        return true
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake {
            fetchColors()
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    let defaults = UserDefaults.standard
    var selectedPaletteType: String = "monochrome"
    var selectedColorCount: Int = 50
    var colors: Scheme? = nil
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        // Do any additional setup after loading the view.
        fetchColors()
        let randomColor = GenerateColors.shared.generateRandomColor()
        print(randomColor)
        print("PALETTE TYPE: ", selectedPaletteType)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //check to see what paletteType to generate
        if defaults.bool(forKey: "monochromeCell") {
            selectedPaletteType = "monochrome"
        } else if defaults.bool(forKey: "monochromeDarkCell") {
            selectedPaletteType = "monochrome-dark"
        } else if defaults.bool(forKey: "monochromeLightCell") {
            selectedPaletteType = "monochrome-light"
        } else if defaults.bool(forKey: "analogicCell") {
            selectedPaletteType = "analogic"
        } else if defaults.bool(forKey: "complementCell") {
            selectedPaletteType = "complement"
        } else if defaults.bool(forKey: "analogicComplementCell") {
            selectedPaletteType = "analogic-complement"
        } else if defaults.bool(forKey: "triadCell") {
            selectedPaletteType = "triad"
        } else if defaults.bool(forKey: "quadCell") {
            selectedPaletteType = "quad"
        } else {
            selectedPaletteType = "monochrome"
        }
        
        selectedColorCount = (defaults.object(forKey: "picker") as? Int) ?? 50
        
        print("SELECTED PALETTE TYPE: ", selectedPaletteType)
        print("SELECTED COLOR COUNT: ", selectedColorCount)

        
    }
    
    func fetchColors(){
        let randomColor = GenerateColors.shared.generateRandomColor()
        Networking.shared.getPalette(mode: selectedPaletteType, hex: randomColor, count: selectedColorCount) { [self] result in
            
            switch result {
            case .success(let result):
                colors = result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching colors in completion: ", error)
            }
        }
    }
    
    @IBAction func getPalleteButton(_ sender: UIButton) {
        fetchColors()
    }
    
    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        guard let ColorSettingsTableViewController = storyboard?.instantiateViewController(withIdentifier: "ColorSettingsTableViewController") as? ColorSettingsTableViewController else { return }
        navigationController?.pushViewController(ColorSettingsTableViewController, animated: true)
    }
    
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors?.colors.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let color = colors?.colors[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell()}
        cell.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cell.widthAnchor.constraint(equalToConstant: 60).isActive = true
        if let uiColor = color?.hex.clean {
            print(uiColor)
            cell.colorView.backgroundColor = hexStringToUIColor(hex: uiColor)
        }
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = colors?.colors[indexPath.item]
        let alert = UIAlertController(title: "Selected \(item!.name.value)!", message: "The hex value (\(item!.hex.clean)) was copied to your clipboard.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(cancel)
        UIPasteboard.general.string = item!.hex.clean
        present(alert, animated: true)
        
    }
    
    
}

