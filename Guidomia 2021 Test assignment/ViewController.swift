//
//  ViewController.swift
//  Guidomia 2021 Test assignment
//
//  Created by Brahim El Mssilha on 12/8/2022.
//

import UIKit

class ViewController: UIViewController {
    
  
    lazy var tableView: UITableView = {
       
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.sectionHeaderTopPadding = 0
        tableView.register(UINib(nibName: "ShowItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var data: [ShowCar] = []
    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        setupData()
    }
    
    func setupData() {
        
        do {
          data = try JSONLoaderService.loadJSONData()
        } catch {
            print("Error", error)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowItemTableViewCell
        
        let item = data[indexPath.section]
        cell.labelTitle.text = item.make
        cell.labelSubTitle.text = "Price: \(item.marketPrice)"
        cell.imageViewCar.image = UIImage(named: item.image)
        cell.setupRating(rate: item.rating)
        cell.labelBottom.text = ""
        
        let bottomText = NSMutableAttributedString()
        if selectedIndex == indexPath {
            if !item.prosList.isEmpty {
                
                let expandedText = NSMutableAttributedString(string: "Pros:", attributes: [
                    .font: UIFont.systemFont(ofSize: 17, weight: .bold)
                ])
                for text in item.prosList where !text.isEmpty {
                    expandedText.append(.init(string: "\n* \(text)", attributes: [
                        .font: UIFont.systemFont(ofSize: 17)
                    ]))
                }
                expandedText.append(.init(string: "\n"))
                bottomText.append(expandedText)
            }
            
            if !item.consList.isEmpty {
                
                let expandedText = NSMutableAttributedString(string: "\nCons:", attributes: [
                    .font: UIFont.systemFont(ofSize: 17, weight: .bold)
                ])
                for text in item.prosList where !text.isEmpty {
                    expandedText.append(.init(string: "\n* \(text)", attributes: [
                        .font: UIFont.systemFont(ofSize: 17)
                    ]))
                }
                expandedText.append(.init(string: "\n"))
                bottomText.append(expandedText)
            }
            
            cell.labelBottom.attributedText = bottomText
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
        
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        13
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .white
        let line = UIView()
        line.backgroundColor = .orange
        
        view.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        line.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        line.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        line.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedIndex == nil {
            
            selectedIndex = indexPath
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }else if let oldIndex = selectedIndex {
            
            if oldIndex == indexPath {
                
                selectedIndex = nil
                tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                selectedIndex = indexPath
                tableView.reloadRows(at: [oldIndex, indexPath], with: .automatic)
            }
        }
    }
}
