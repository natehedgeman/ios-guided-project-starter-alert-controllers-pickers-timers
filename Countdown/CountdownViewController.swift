//
//  CountdownViewController.swift
//  Countdown
//
//  Created by Paul Solt on 5/8/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    
    @IBOutlet weak var CountdownPickerView: CountdownPicker!
    @IBOutlet weak var CountdownLabel: UILabel!
    
    private let countdown: Countdown = Countdown()
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SS"
        formatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countdown.duration = CountdownPickerView.duration
        countdown.delegate = self
        CountdownLabel.font = UIFont.monospacedDigitSystemFont(ofSize: self.CountdownLabel.font.pointSize, weight: .medium)
        updateViews()
        CountdownPickerView.countDownDelegate = self
        
       
    }
   
    
    @IBAction func StartButtonTapped(_ sender: Any) {
        //self.showAlert()
        let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: timerFinished(time:))
        countdown.start()
    }
    
    @IBAction func ResetButtonTapped(_ sender: Any) {
        
        countdown.reset()
        updateViews()
        
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Timer Finished", message: "Your Countdown Is Finished", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
    private func timerFinished(time: Timer) {
        self.showAlert()
        updateViews()
    }
    
    func string(from duration: TimeInterval) -> String {
        let date = Date(timeIntervalSinceReferenceDate: duration)
        return dateFormatter.string(from: date)
    }
}

extension CountdownViewController: CountdownDelegate {
    func countdownDidUpdate(timeRemaining: TimeInterval) {
        updateViews()
    }
    
    func countdownDidFinish() {
        updateViews()
        showAlert()
    }
    
    private func updateViews() {
        self.CountdownLabel.text = string(from: countdown.timeRemaining)
        switch self.countdown.state {
        case .started:
            CountdownLabel.text = string(from: self.countdown.timeRemaining)
        case .finished:
            CountdownLabel.text = string(from: 0)
        case .reset:
            CountdownLabel.text = string(from: countdown.duration)
        }
        
    }
}

extension CountdownViewController: CountdownPickerDelegate {
    func countdownPickerDidSelect(duration: TimeInterval) {
        countdown.duration  = duration
        updateViews()
        
    
    }
}
