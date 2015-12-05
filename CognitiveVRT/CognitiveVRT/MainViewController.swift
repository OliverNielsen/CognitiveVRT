//
// Created by Oliver Nielsen on 03/12/15.
// Copyright (c) 2015 Oliver Nielsen. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


class MainViewController: GenericViewController {
    
    private let maxCircleCount: NSInteger = 5
    private let circleDiameterSmall: CGFloat = 10
    private let circleDiameterLarge: CGFloat = 200
    
    private var circleShowDate: NSDate?;
    
    private var responseArray: NSArray = [Double]();
    
    private lazy var largeCircle: UIButton = {
        var button = UIButton(type: .Custom)
        button.layer.cornerRadius = self.circleDiameterLarge / 2
        button.addTarget(self, action: "tappedLargeCirlce:", forControlEvents: .TouchUpInside)
        button.backgroundColor = .greenColor()
        button.hidden = true
        
        return button
    }()
    
    private lazy var smallCircle: UIView = {
        var button = UIButton(type: .Custom)
        button.layer.cornerRadius = self.circleDiameterSmall / 2
        button.backgroundColor = .redColor()
        
        return button
    }()
    
    
    override init() {
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSubViews()
        self.setupConstraints()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        startGame()
    }
    
    func setupSubViews() {
        self.view.addSubview(self.largeCircle)
        self.view.addSubview(self.smallCircle)
    }

    func setupConstraints() {
        self.largeCircle.snp_makeConstraints { (make) -> Void in
            make.height.width.equalTo(self.circleDiameterLarge)
            make.centerX.centerY.equalTo(self.largeCircle.superview!)
        }

        self.smallCircle.snp_makeConstraints { (make) -> Void in
            make.height.width.equalTo(self.circleDiameterSmall)
            make.centerX.centerY.equalTo(self.largeCircle)
        }
    }
    
    private func startGame() {
        self.responseArray = [];
        self.fire()
    }
    
    private func fire() {
        self.handleTitle()
        self.handleHiddenStatus(true)
        
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(self.randomBetweenNumbers(0.5, secondNum: 5)), target: self, selector: "showCircle", userInfo: nil, repeats: false)
    }
    
    func showCircle() {
        self.handleHiddenStatus(false)
        
        self.circleShowDate = NSDate.init()
    }
    
    func tappedLargeCirlce(sender: UIButton!) {
        var tempTimeInterval = abs(Double((self.circleShowDate?.timeIntervalSinceNow)!)) // NSTimeInterval -> Double -> Abs of the double
        tempTimeInterval *= 1000 // sec to ms

        let timeInterval = self.threeDecimals(tempTimeInterval)
        self.responseArray = self.responseArray.arrayByAddingObject(timeInterval)
        
        if (self.responseArray.count == self.maxCircleCount) {
            self.handleScore()
        }
        else {
            let alertView = UIAlertController.init(title: "Good Job", message: "Your response time was " + String(timeInterval) + "ms", preferredStyle: UIAlertControllerStyle.Alert)
            let alertActionNext = UIAlertAction.init(title: "Next", style: UIAlertActionStyle.Default) { (action) -> Void in
                self.fire()
            }
            
            alertView.addAction(alertActionNext)
            
            self.presentViewController(alertView, animated: true) { () -> Void in
                self.handleHiddenStatus(true)
            }
        }
    }
    
    private func handleScore() {
        var tempTotalResult = 0.0;

        for (var i = 0; i < self.responseArray.count; i++) {
            tempTotalResult += self.responseArray[i].doubleValue
        }
        
        tempTotalResult /= Double(self.responseArray.count)
        
        let totalResult = self.threeDecimals(tempTotalResult)
        
        let alertView = UIAlertController.init(title: "Game Completed", message: "Your average response time was " + String(totalResult) + "ms", preferredStyle: UIAlertControllerStyle.Alert)
        let alertActionNext = UIAlertAction.init(title: "Want to play again?", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.startGame()
        }
        
        alertView.addAction(alertActionNext)
        
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    // http://stackoverflow.com/a/26029530/2661833
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    // 3 decimals (2 decimals is 100 etc)
    func threeDecimals(number: Double) -> Double {
        return round(1000 * number) / 1000
    }

    private func handleHiddenStatus(hidden: Bool) {
        self.largeCircle.hidden = hidden
        self.smallCircle.hidden = !hidden
    }
    
    private func handleTitle() {
        self.title = "Trial " + String(self.responseArray.count + 1) + " of " + String(self.maxCircleCount)
    }


    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}
