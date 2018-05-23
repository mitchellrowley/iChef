//
//  ViewController.swift
//  Mockup03
//
//  Created by Mitch's MacBook on 5/23/18.
//  Copyright © 2018 Pocket Chef LLC. All rights reserved.
//

import UIKit
import Speech
import AVFoundation




class eChef : UIViewController
    
{
    
    /// The speech recogniser used by the controller to record the user's speech.
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    
    /// The current speech recognition request. Created when the user wants to begin speech recognition.
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    /// The current speech recognition task. Created when the user wants to begin speech recognition.
    private var recognitionTask: SFSpeechRecognitionTask?
    
    /// The audio engine used to record input from the microphone.
    private let audioEngine = AVAudioEngine()
    
    
    
    var CurrentStep: Int!
    //    @IBOutlet var textEdit: UITextView!
   // @IBOutlet weak var textEdit: UITextView!
    //    @IBOutlet var NextStep: UIButton!
    func Speak( _ sender: String )
    {
        CurrentStep = CurrentStep + 1
        if ( CurrentStep > NumberSteps - 1 )
        {
            CurrentStep = 0
            
        }
        //textEdit.text = Steps[CurrentStep]
        
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
        let myUtterance = AVSpeechUtterance(string: sender)
        myUtterance.voice = voiceToUse
        myUtterance.rate = 0.5
        synth.speak(myUtterance)
        
    }
    
    
    var NumberSteps: Int!
    
    var Steps : [String] = ["Bring a large pot of water to a boil, and salt generously.", "Add the pasta, and boil according to package directions until al dente.", "Strain, and toss with a splash of oil.", "Slice the chicken into 1/4-inch-thick strips, and lay them on a plate or a sheet of waxed paper.", "Season with salt and pepper to taste.", "Heat a large skillet over medium heat, and add 2 tablespoons of the butter.", " When the butter melts, raise the heat to medium-high and add the chicken in 1 layer.", "Cook, without moving the pieces, until the underside has browned, 1 to 2 minutes.", "Flip the pieces, and cook until browned and fully cooked through, 2 to 3 minutes more.", "Transfer the chicken to a medium bowl.", "Reduce the heat to medium, and add the remaining 6 tablespoons butter.", "Scrape the bottom of the skillet with a wooden spoon to release any browned bits.", "When the butter has mostly melted, whisk in the cream and nutmeg and bring to a simmer, then cook for 2 minutes.", "Lower the heat to keep the sauce just warm.", "Whisk the Parmigiano-Reggiano into the sauce.", "Add the chicken and cooked pasta, and toss well.",
                            "Bon Appetit!" ]
    
    
    
    
    
    func PerformRecognition()
    {
        try! self.startRecording()
        
    }
    //Testing the commit 
    var transcribed: String="None"
    //    @IBOutlet var button:UIButton!
    var speechResult = SFSpeechRecognitionResult()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func stopRecording() {
    
        
        
        audioEngine.stop()
        recognitionRequest?.endAudio()

        // Cancel the previous task if it's running
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
    }
    
    func checkForActionPhrases() {
        var addNote = false
        var addReminder = false
        
        for segment in speechResult.bestTranscription.segments {
            // Don't search until the transcription size is at least
            // the size of the shortest phrase
            if segment.substringRange.location >= 5 {
                // Separate segments to single words
                let best = speechResult.bestTranscription.formattedString
                let indexTo = best.index(best.startIndex, offsetBy: segment.substringRange.location)
                let substring = best.substring(to: indexTo)
                
                transcribed = best
                // Search for phrases
                addNote = substring.lowercased().contains("note ")
                addReminder = substring.lowercased().contains("remind")
            }
        }
        
        //if addNote {
        //     recordedTextLabel.text = remove(commands: noteCommands, from: recordedTextLabel.text)
        //      addNoteTapped(nil)
        //  } else if addReminder {
        //      recordedTextLabel.text = remove(commands: remindCommands, from: recordedTextLabel.text)
        //      addReminderTapped(nil)
        //  }
    }
    
    @objc func timerEnded() {
        // If the audio recording engine is running stop it and remove the SFSpeechRecognitionTask
        if audioEngine.isRunning {
            stopRecording()
            checkForActionPhrases()
        }
    }
    
    private func startRecording() throws {
        if !audioEngine.isRunning {
            let timer = Timer(timeInterval: 5.0, target: self, selector: #selector(eChef.timerEnded), userInfo: nil, repeats: false)
            RunLoop.current.add(timer, forMode: .commonModes)
            
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
            
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            
            guard let inputNode:AVAudioInputNode! = audioEngine.inputNode else { fatalError("There was a problem with the audio engine") }
            guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create the recognition request") }
            
            // Configure request so that results are returned before audio recording is finished
            recognitionRequest.shouldReportPartialResults = true
            
            // A recognition task is used for speech recognition sessions
            // A reference for the task is saved so it can be cancelled
            recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest)
            { result, error in
                var isFinal = false
                
                if let result = result {
                    print("result: \(result.isFinal)")
                    isFinal = result.isFinal
                    
                    self.speechResult = result
                    //self.recordedTextLabel.text = result.bestTranscription.formattedString
                    
                }
                
                if error != nil || isFinal {
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    
                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                }
                
                //self.addNote.isEnabled = self.recordedTextLabel.text != ""
                //self.addReminder.isEnabled = self.recordedTextLabel.text != ""
            }
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                self.recognitionRequest?.append(buffer)
            }
            
            print("Begin recording")
            audioEngine.prepare()
            try audioEngine.start()
            
            //isRecordingLabel.text = "Recording"
        }
        
    }
    
    // MARK: SFSpeechRecognizerDelegate
    
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        print("Recognizer availability changed: \(available)")
        
        if !available {
            let alert = UIAlertController(title: "There was a problem accessing the recognizer", message: "Please try again later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func recordAndRecognizeSpeech()->Void
    {
        
    }
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        

        NumberSteps = Steps.count
        CurrentStep = 0
        var run: Bool = true
        while( run == true ) {
            PerformRecognition()
            Speak (transcribed)
        }
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
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



