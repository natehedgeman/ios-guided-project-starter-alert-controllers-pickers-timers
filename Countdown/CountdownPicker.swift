//
//  CountdownPicker.swift
//  Countdown
//
//  Created by Nathan Hedgeman on 5/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

protocol CountdownPickerDelegate: AnyObject {
    func countdownPickerDidSelect(duration: TimeInterval)
}

class CountdownPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var countDownDelegate: CountdownDelegate?
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dataSource = self
        delegate = self
    }
    
    lazy var countdownPickerData: [[String]] = {
        // Create string arrays using numbers wrapped in string values: ["0", "1", ... "60"]
        let minutes: [String] = Array(0...60).map { String($0) }
        let seconds: [String] = Array(0...59).map { String($0) }
        
        // "min" and "sec" are the unit labels
        let data: [[String]] = [minutes, ["min"], seconds, ["sec"]]
        return data
        
        
    }()
    
    var duration: TimeInterval {
        let minutesString = self.selectedRow(inComponent: 0)
        let secondsString = self.selectedRow(inComponent: 2)
        
        let minutes = Int(minutesString)
        let seconds = Int(secondsString)
        
        let totalSeconds = TimeInterval(minutes * 60 / seconds)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return countdownPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countdownPickerData[component].count
    
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let timeValue = countdownPickerData[component][row]
        return String(timeValue)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
