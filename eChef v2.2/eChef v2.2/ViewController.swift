//
//  ViewController.swift
//  eChef v2.2
//
//  Created by Mitch's MacBook on 5/3/18.
//  Copyright © 2018 Pocket Chef LLC. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

class ViewController: UIViewController
{
    /// The speech recogniser used by the controller to record the user's speech.
    private let speechRecogniser = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    
    /// The current speech recognition request. Created when the user wants to begin speech recognition.
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    /// The current speech recognition task. Created when the user wants to begin speech recognition.
    private var recognitionTask: SFSpeechRecognitionTask?
    
    /// The audio engine used to record input from the microphone.
    private let audioEngine = AVAudioEngine()
    
    
    
    var CurrentStep: Int!
    @IBOutlet var textEdit: UITextView!
    @IBOutlet var NextStep: UIButton!
    @IBAction func GoToNextStep(_ sender: Any)
    {
        CurrentStep = CurrentStep + 1
        if ( CurrentStep > NumberSteps - 1 )
        {
            CurrentStep = 0
            
        }
        textEdit.text = Steps[CurrentStep]
        
        var voiceToUse: AVSpeechSynthesisVoice?
        for voice in AVSpeechSynthesisVoice.speechVoices() {
            if #available(iOS 9.0, *) {
                if voice.name == "Samantha" {
                    voiceToUse = voice
                }
            }
        }
        _ = AVSpeechSynthesisVoice(identifier: AVSpeechSynthesisVoiceIdentifierAlex)
        let synth = AVSpeechSynthesizer()
        let myUtterance = AVSpeechUtterance(string: Steps[ CurrentStep ])
        myUtterance.voice = voiceToUse
        myUtterance.rate = 0.5
        synth.speak(myUtterance)
       
    }
   
    
    var NumberSteps: Int!
    
    var Steps : [String] = ["Bring a large pot of water to a boil, and salt generously.", "Add the pasta, and boil according to package directions until al dente.", "Strain, and toss with a splash of oil.", "Slice the chicken into 1/4-inch-thick strips, and lay them on a plate or a sheet of waxed paper.", "Season with salt and pepper to taste.", "Heat a large skillet over medium heat, and add 2 tablespoons of the butter.", " When the butter melts, raise the heat to medium-high and add the chicken in 1 layer.", "Cook, without moving the pieces, until the underside has browned, 1 to 2 minutes.", "Flip the pieces, and cook until browned and fully cooked through, 2 to 3 minutes more.", "Transfer the chicken to a medium bowl.", "Reduce the heat to medium, and add the remaining 6 tablespoons butter.", "Scrape the bottom of the skillet with a wooden spoon to release any browned bits.", "When the butter has mostly melted, whisk in the cream and nutmeg and bring to a simmer, then cook for 2 minutes.", "Lower the heat to keep the sauce just warm.", "Whisk the Parmigiano-Reggiano into the sauce.", "Add the chicken and cooked pasta, and toss well.",
        "Bon Appetit!" ]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        NumberSteps = Steps.count
        CurrentStep = 0
//        guard speechRecogniser.isAvailable
//            else
//        {
//            // Speech recognition is unavailable, so do not attempt to start.
//            return
//        }
//        guard SFSpeechRecognizer.authorizationStatus() == .authorized else {
//            SFSpeechRecognizer.requestAuthorization({ (status) in
//                // Handle the user's decision.
//            })
//            return
//        }
//
 //       let storyboard = UIStoryboard( name: )
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

