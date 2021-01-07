//
//  ViewController.swift
//  PangleQuickStartDemo
//
//  Created by Chan Gu on 2020/10/07.
//

import UIKit

class ViewController: UIViewController {
    
    let cellReuseIdentifier = "cell"
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let adsTypeArray = ["Origin Native Ad", "Template Native Ad", "Rewarded Video Ad", "Full Screen Video", "Template Banner","Set GDPR"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return adsTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = adsTypeArray[indexPath.section]
        cell.textLabel?.textAlignment = .center
        
        // add border and color
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section)")

        switch indexPath.section {
        case 0:
            performSegue(withIdentifier: "moveToNativeSample", sender: self)
            break
        case 1:
             performSegue(withIdentifier: "moveToTemplateNativeSample", sender: self)
            break
        case 2:
             performSegue(withIdentifier: "moveToRewardedVideo", sender: self)
            break
        case 3:
            performSegue(withIdentifier: "moveToFullScreenVideo", sender: self)
            break
        case 4:
            performSegue(withIdentifier: "moveToTemplateBanner", sender: self)
            break
        case 5:
            BUAdSDKManager.openGDPRPrivacy(fromRootViewController: self) { (isAgreed) in BUAdSDKManager.setGDPR(isAgreed ?0:1)}
            break
        default: break
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}

