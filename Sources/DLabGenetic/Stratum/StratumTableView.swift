//
//  StratumTableView.swift
//  DLabGenetic
//
//  Created by Rodney Dyer on 5/28/25.
//


import SwiftUI


#if os(macOS)
import AppKit

public struct StratumTableView: NSViewRepresentable {
    
    public var stratum: Stratum
    
    public func makeCoordinator() -> StratumTableCoordinator {
        StratumTableCoordinator( stratum: stratum )
    }
    
    public func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.autohidesScrollers = true
        
        let tableView = NSTableView()
        tableView.delegate = context.coordinator
        tableView.dataSource = context.coordinator
        tableView.selectionHighlightStyle = .none
        tableView.usesAlternatingRowBackgroundColors = true
        tableView.gridStyleMask = [.solidHorizontalGridLineMask, .solidVerticalGridLineMask]
        
        stratum.allHeadings.forEach { key in
            let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(key))
            column.title = key
            column.isEditable = true
            column.width = 120
            tableView.addTableColumn(column)
        }
        
        /*
        let fillerColumn = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Filler"))
        fillerColumn.title = ""
        fillerColumn.isEditable = false
        fillerColumn.resizingMask = .autoresizingMask
        tableView.addTableColumn(fillerColumn)
        */
        scrollView.documentView = tableView
        return scrollView
    }
    
    public func updateNSView(_ nsView: NSScrollView, context: Context) {
        if let tableView = nsView.documentView as? NSTableView {
            tableView.reloadData()
        }
    }
    
    
    
    /// Coordiantor Class
    public class StratumTableCoordinator: NSObject, NSTableViewDelegate, NSTableViewDataSource, NSTextFieldDelegate {
        
        var stratum: Stratum
        
        public init(stratum: Stratum) {
            self.stratum = stratum
        }
        
        public func numberOfRows(in tableView: NSTableView) -> Int {
            return stratum.individuals.count
        }
        
        public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
            guard let column = tableColumn else { return nil }
            let key = column.identifier.rawValue
            let value = stratum.getProperty(idx: row, key: key)
            
            let textField = NSTextField()
            textField.stringValue = value
            textField.isEditable = true
            textField.isBordered = false
            textField.drawsBackground = false
            textField.backgroundColor = .clear
            textField.isBezeled = false
            textField.delegate = self
            textField.tag = row
            textField.identifier = NSUserInterfaceItemIdentifier(key)
            
            // Only allow decimal and numbers
            if ["Latitude", "Longitude"].contains(key) {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 6
                formatter.allowsFloats = true
                formatter.generatesDecimalNumbers = true
                textField.formatter = formatter
            }
            return textField
        }
        
        public func controlTextDidEndEditing(_ obj: Notification) {
            guard let textField = obj.object as? NSTextField,
                  let key = textField.identifier?.rawValue else { return }
            let row = textField.tag
            stratum.setIndividualProperty( idx: row, key: key, value: textField.stringValue )
        }
        
    }
    
}

#elseif os(iOS) || os(visionOS)

import UIKit

public struct StratumTableView: UIViewRepresentable {
    
    public var stratum: Stratum
    
    public func makeCoordinator() -> StratumTableCoordinator {
        StratumTableCoordinator(stratum: stratum)
    }
    
    public func makeUIView(context: Context) -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 44
        return tableView
    }
    
    public func updateUIView(_ uiView: UITableView, context: Context) {
        uiView.reloadData()
    }
    
    public class StratumTableCoordinator: NSObject, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
        
        var stratum: Stratum
        
        public init(stratum: Stratum) {
            self.stratum = stratum
        }
        
        public func numberOfSections(in tableView: UITableView) -> Int {
            return stratum.individuals.count
        }
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return stratum.allHeadings.count
        }
        
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
            let key = stratum.allHeadings[indexPath.row]
            let value = stratum.getProperty(idx: indexPath.section, key: key)
            cell.keyLabel.text = key
            cell.valueField.text = value
            cell.valueField.delegate = self
            cell.valueField.tag = (indexPath.section * 1000) + indexPath.row
            return cell
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            let section = textField.tag / 1000
            let row = textField.tag % 1000
            let key = stratum.allHeadings[row]
            stratum.setIndividualProperty(idx: section, key: key, value: textField.text ?? "")
        }
        
        class Cell: UITableViewCell {
            let keyLabel = UILabel()
            let valueField = UITextField()
            
            override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: reuseIdentifier)
                keyLabel.translatesAutoresizingMaskIntoConstraints = false
                valueField.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(keyLabel)
                contentView.addSubview(valueField)
                
                NSLayoutConstraint.activate([
                    keyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                    keyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                    keyLabel.widthAnchor.constraint(equalToConstant: 100),
                    
                    valueField.leadingAnchor.constraint(equalTo: keyLabel.trailingAnchor, constant: 10),
                    valueField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                    valueField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                    valueField.heightAnchor.constraint(equalToConstant: 30)
                ])
                
                valueField.borderStyle = .roundedRect
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }
    }
}


#endif

