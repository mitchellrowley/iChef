//
//  ViewController.swift
//  Quiz
//
//  Created by ProgrammingMac on 4/10/18.
//  Copyright © 2018 ProgrammingMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var input: UITextField!
    
    let questions: [String] = [
    "What is 7+7?",
    "What is the capital of Vermont?",
    "What is cognac made from?"]
    
    let answers: [String] = [
     "14",
     "Montpelier",
     "Grapes"]
    
    var 😀 : Int = 2
    var currentQuestionIndex: Int = 0
    
    func animateLabelTransitions() {
        let animationClosure = { () -> Void in
            self.questionLabel.alpha = 1
            
        }
        
        // Animate the alpha
        UIView.animate(withDuration: 0.5, animations: animationClosure )
    }
    @IBAction func showNextQuestion( _ sender: UIButton )
    {
        currentQuestionIndex += 1
        if( currentQuestionIndex == questions.count ) {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[ currentQuestionIndex ]
        questionLabel.text = question
        answerLabel.text = "???"
    }
    
    @IBAction func showAnswer( _ sender: UIButton )
    {
        let answer: String = answers[ currentQuestionIndex ]
        answerLabel.text = answer
    }
    
    override func viewDidLoad(  ) {
        super.viewDidLoad()
        questionLabel.text = questions[ currentQuestionIndex ]
    }
}

