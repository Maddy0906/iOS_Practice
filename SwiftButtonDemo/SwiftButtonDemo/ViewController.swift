//
//  ViewController.swift
//  SwiftButtonDemo
//
//  Created by まどか on 2018-01-15.
//  Copyright © 2018 Maddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainStackView: UIStackView!
    let image = UIImage(named:"sliceOfAppPie400x400Black1")
    let myLabel = UILabel()
    var stepper = UIStepper()
    var buttonCount = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        //Iteration 1: Make a button
//        view.addSubview(makeButtonWithText("Indie Button"))
//        configureLabelWithText(text: "Hello, Label")
//        view.addSubview(myLabel)

        //Iteration 3:Button and label in stack view
//        mainStackView.addArrangedSubview(configureLabelWithText(text: "Hello"))
//        mainStackView.addArrangedSubview(makeButtonWithText("Hello,Button"))
//        mainStackView.addArrangedSubview(makeButtonWithText("Hello,Button 2"))
//        mainStackView.addArrangedSubview(makeButtonWithText("Hello,Button 3"))
        
        mainStackView.spacing = 1.0
        configureLabelWithText(text: "Hello, Label")
        configureStepper()
        updateStackView(count: 1)
    }
    
    func configureLabelWithText(text:String) {
        //Set the attributes of the label
        myLabel.frame = CGRect(x: 30, y: 600, width:150, height:36)
        myLabel.textColor = UIColor.gray
        myLabel.font = UIFont(name: "Chalkduster", size: 18)
        myLabel.text = text
        myLabel.textAlignment = .right
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: view making methods
    func makeButtonWithText(_ text:String) -> UIButton {

        let myButton = UIButton(type: UIButtonType.system)
        
        myButton.frame = CGRect(x: 30, y: 30, width: 150, height: 150)
        myButton.backgroundColor = UIColor.blue
        //State dependent properties title and title color
        myButton.setTitle(text, for: .normal)
        myButton.setTitleColor(UIColor.white, for: .normal)
        myButton.setTitle("Touched!!", for: .highlighted)
        myButton.setTitleColor(UIColor.yellow, for: .highlighted)
        //highlightd background image
        myButton.setBackgroundImage(#imageLiteral(resourceName: "sliceofapppie400x400black1"), for: UIControlState.highlighted)
        
        //Assign a target (i.e action) to the button
        myButton.addTarget(self, action: #selector(helloButton), for: .touchUpInside)
        
        return myButton
       
    }
    
    //MARK: - Actions and Selectors
    @IBAction func helloButton(sender:UIButton){
        if myLabel.text !=  sender.titleLabel?.text {
            myLabel.text = sender.titleLabel?.text
        } else {
            myLabel.text = "Hello Pizza"
        }
    }
    
    func colorStaclView() {
        let subviewCount = mainStackView.arrangedSubviews.count
        let colorIncrement:CGFloat = 1.0 / CGFloat(subviewCount)
        var color:CGFloat = 0.0
        for aView in mainStackView.arrangedSubviews{
            aView.backgroundColor = UIColor(
                hue: color,
                saturation: 1.0,
                brightness: 1.0,
                alpha: 1.0)
                color += colorIncrement
            }
        }
    
    func rainbowButtons(count:Int){
        for i in 1...count{
            let titleString = String(format:"Hello Button %i", i)
            let button = makeButtonWithText(titleString)
            mainStackView.addArrangedSubview(button)
        }
        colorStaclView()
    }
    
    func configureStepper(){
        //Set the attributes of the stepper
        stepper.minimumValue = 1.0
        stepper.maximumValue = 10.0
        stepper.stepValue = 1.0
        stepper.addTarget(self, action: #selector(stepPressed), for: .touchUpInside)
    }
    
    @objc func stepPressed(sender:UIStepper){
        let buttonCount = Int(sender.value)
        updateStackView(count: buttonCount)
    }
    
    func updateStackView(count count:Int){
    //clear the stackView Array
     for aView in mainStackView.arrangedSubviews{
     mainStackView.removeArrangedSubview(aView)
     aView.removeFromSuperview()
     }
     //add the stack view back in
     //mainStackView.addArrangedSubview(stepper)
     mainStackView.addArrangedSubview(myLabel)
     rainbowButtons(count: count)
     mainStackView.addArrangedSubview(makeStackViewStepper())
     }
    
    func stepperButtonsWithText(text:String, action: Selector) -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitle(text, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    func makeStackViewStepper() -> UIStackView {
        var viewArray = [UIView]()
        viewArray += [stepperButtonsWithText(text: "Add", action: #selector(addButton))]
        viewArray += [stepperButtonsWithText(text: "Reset", action: #selector(resetButton))]
        viewArray += [stepperButtonsWithText(text: "Remove", action: #selector(removeButton))]
        
        let stackView = UIStackView(arrangedSubviews: viewArray)
        //properties for the stack view
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 1.0
        return stackView
    }
    
    @objc func addButton(sender:UIButton) {
        buttonCount += 1
        updateStackView(count: buttonCount)
    }
    @objc func resetButton(sender:UIButton) {
        buttonCount = 1
        updateStackView(count: buttonCount)
    }
    @objc func removeButton(sender:UIButton){
        if buttonCount > 1 {
            buttonCount -= 1
        }else{
            buttonCount = 1
        }
        updateStackView(count: buttonCount)
    }

}
    



