//
//  Experimental.swift
//  Mockup02
//
//  Created by ProgrammingMac on 5/9/18.
//  Copyright © 2018 Julien Esposito. All rights reserved.
//

import UIKit
import Speech

class Experimental : UIViewController
{
    @IBAction func PerformRecognition( _ sender: UIButton )
    {
        try! self.startRecording()

    }
    
    @IBOutlet var transcribed: UILabel!
    @IBOutlet var button:UIButton!
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
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
                
                transcribed.text = best
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
            let timer = Timer(timeInterval: 5.0, target: self, selector: #selector(Experimental.timerEnded), userInfo: nil, repeats: false)
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
            recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

