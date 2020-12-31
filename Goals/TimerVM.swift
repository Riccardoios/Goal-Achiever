//
//  TimerBrain.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 10/04/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import Combine
import AVFoundation
import UserNotifications
import SwiftUI
import CoreData

/*
 the logic of counting the session:
 bug 1: it saves the  session in case it's already started it saves all
 bug 2: sometimes i have to press play 2 times depending of ??
 bug 3: take a break notification trigged after a while
 */

class TimerViewModel: ObservableObject {
    
    
    // for request reviews
    let runIncrementerSetting = "numberOfRuns"  // UserDefauls dictionary key where we store number of runs
//    let minimumRunCount = 3                     // Minimum number of runs that we should have until we ask for review
    
    
    //    @Published var timersArray =  [10, 5, 10]
    let objectWillChange = PassthroughSubject<Void, Never>()// for user default 
    
    @UserDefault("timersArray", defaultValue: [25*60, 5*60, 25*60, 5*60, 25*60, 5*60, 25*60, 5*60])
    var timersArray: Array<Int> {
        willSet {
            objectWillChange.send()
        }
    }
    @UserDefault("arrayForThePercentage", defaultValue: [25*60, 5*60, 25*60, 5*60, 25*60, 5*60, 25*60, 5*60])
    var arrayForThePercentage: Array<Int> {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("longBreakTime", defaultValue: 15*60)
    var longBreakTime: Int {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("remidUserToActivateNotification", defaultValue: false)
    var remidUserToActivateNotification: Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("enableNoStop", defaultValue: false)
    var enableNoStop: Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("indexOfTimersArray", defaultValue: 0)
    var indexOfTimersArray: Int {
        willSet {
            objectWillChange.send()
        }
    }
      
    
    
    @UserDefault("normalTimer", defaultValue: 0)
    var normalTimer: Int {
        willSet {
            objectWillChange.send()
                    }
    }
    
    @Published var arrayOfInput = [25,5,4,15]
    //  @Published var indexOfTimersArray = 0
    @Published var percentage: CGFloat = 0
    //  @Published var longBreakTime = 10
    //  @Published var enableNoStop = false
    
    @Published var colorBar1 = UIColor(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1))
    @Published var colorBar2 = UIColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.7845141267))
    
    @Published var backgroundColor = (#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00))
    @Published var firstColorText = (#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    @Published var secondColorText = (#colorLiteral(red: 0.968627451, green: 0.5294117647, blue: 0.2392156863, alpha: 0.8337435788))
    @Published var firstSizeFont : CGFloat = 45
    @Published var secondSizeFont : CGFloat = 22
    @Published var secondForSession: Int32 = 0
    
    @Published var saveSessionValue:Int32 = 1
    
    //  @Published var remidUserToActivateNotification = true // this one needs to be stored on userdefault for the moment i will put it
    //  var arrayForThePercentage =  [10, 5, 10]// this has to be the same as timersarray and it shouldn be modify the nuber inside because they rappresent the 100% of the bar (the denominator)
//    var isNormalTimer = false
    
    var isPressedTomatoTimer = 0
    var isPressedNormalTimer = 0
    var audioPlayer : AVAudioPlayer?
    
    // for the background and foreground guys
    weak var myTimer : Timer?
    var timeDateBackground = DateComponents()
    var timeDateForeground = DateComponents()
    
    var count = 0
    
    var motivationQuote = ["Goals give us a roadmap to follow.", "Goals are a great way to hold ourselves accountable, even if we fail.",  "Setting goals and working to achieving them helps us define what we truly want in life.", "Setting goals  helps us prioritize things.", "“If you want to be happy, set a goal that commands your thoughts, liberates your energy and inspires your hopes.” —Andrew Carnegie", "“All who have accomplished great things have had a great aim, have fixed their gaze on a goal which was high, one which sometimes seemed impossible.” —Orison Swett Marden", "“Our goals can only be reached through a vehicle of a plan, in which we must fervently believe, and upon which we must vigorously act. There is no other route to success.” —Pablo Picasso", "“Success is the progressive realization of a worthy goal or ideal.” —Earl Nightingale", "“You have to set goals that are almost out of reach. If you set a goal that is attainable without much work or thought, you are stuck with something below your true talent and potential.” —Steve Garvey", "“By recording your dreams and goals on paper, you set in motion the process of becoming the person you most want to be. Put your future in good hands—your own.” —Mark Victor Hansen", "“The trouble with not having a goal is that you can spend your life running up and down the field and never score.” —Bill Copeland", "All successful people have a goal. No one can get anywhere unless he knows where he wants to go and what he wants to be or do. ” —Norman Vincent Peale", "“Goals. There’s no telling what you can do when you get inspired by them. There’s no telling what you can do when you believe in them. And there’s no telling what will happen when you act upon them.” —Jim Rohn"].randomElement()!
    
    
    //MARK: - NORMAL TIMER FUNCS
    
    
    
    func playNormalTimer() {
        
        self.percentage = 100
        myTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.normalTimer += 1
            self.secondForSession += 1
        }
        
    }
    
    func playPauseNormalTimer() {
        
        if isPressedNormalTimer % 2 == 0 {
            playNormalTimer()
        } else {
            myTimer?.invalidate()
             
        }
        isPressedNormalTimer+=1
        
    }
    
    func backwardNormalTimer() {
        myTimer?.invalidate()
        normalTimer = 0
        isPressedNormalTimer+=1
    }
    
    
    
    //MARK: - TOMATO TIMER FUNCS
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        if Int(time) < 0 { // Don't show the seconds less than 0 because the timer can go -1 when i stop it at 0 (review this)
            return "Done!"
        }
        
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func playPauseTomatoTimer() {
        
        if isPressedTomatoTimer % 2 == 0 {
            playTimer()
        } else {
            myTimer?.invalidate()
            
            // remove timer notification planned
            //            let center = UNUserNotificationCenter.current()
            //            center.removePendingNotificationRequests(withIdentifiers: ["timer notification"])
            
            
        }
        
        isPressedTomatoTimer+=1
    }
    
    func forward() {
        
        if indexOfTimersArray < timersArray.count - 1 {
            indexOfTimersArray += 1
        }
    }
    
    func backward() {
        if indexOfTimersArray > 0 {
            indexOfTimersArray -= 1
        }
        if indexOfTimersArray == 0 {
            reset()
        }
    }
    
    func playTimer() {
        //                timer.invalidate()
        
        myTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timersArray[self.indexOfTimersArray] -= 1
//            if self.isNormalTimer {
//                self.timersArray[self.indexOfTimersArray] += 1
//            } else if !self.isNormalTimer { // !self.isNormalTimer
//                self.timersArray[self.indexOfTimersArray] -= 1
//            }
            self.secondForSession += 1
            // add second to record
            
            
            self.percentage =  100 - (100 *  (CGFloat(self.timersArray[self.indexOfTimersArray])) / CGFloat(self.arrayForThePercentage[self.indexOfTimersArray]))
            //            print("index:", self.indexOfTimersArray, "second:", self.timersArray[self.indexOfTimersArray])
            
            
            
            if self.timersArray[self.indexOfTimersArray] < 0 { // stop the timer when the array arrive to the end
                self.playRingTone(); // and play the sound ring
                guard self.indexOfTimersArray < self.timersArray.count - 1 else
                {   self.isPressedTomatoTimer+=1
                    return self.myTimer!.invalidate()  }
                
                
                
                if self.enableNoStop == true { // logic for enable no stop timers
                    self.indexOfTimersArray += 1
                } else {
                    self.myTimer?.invalidate()
                    self.isPressedTomatoTimer+=1
                    self.indexOfTimersArray += 1
                }
                
                
            }
        }
    }
    
    
    
    func reset() {
        myTimer?.invalidate()
//        isNormalTimer = false
        indexOfTimersArray = 0
        timersArray = setTimers(worktime: arrayOfInput[0], breaktime: arrayOfInput[1], cycles: arrayOfInput[2])
        longBreakTime = arrayOfInput[3]
        
        isPressedTomatoTimer = 0
        
        
    }
    
    func setTimers(worktime:Int, breaktime:Int, cycles:Int) -> Array<Int> {
        timersArray.removeAll()
        for _ in 1...cycles {
            timersArray.append(worktime*60)
            timersArray.append(breaktime*60)
        }
        // try this after
        percentage = 0.0
        isPressedTomatoTimer = 0
        arrayForThePercentage = timersArray
        return timersArray
        
    }
    
    
    func setLongBreak() {
        indexOfTimersArray = indexOfTimersArray == 0 ? (indexOfTimersArray + 1) : indexOfTimersArray
        
        // if index it's even add one if it's odd keep it like this, this way the index will always stay even for worktimes and odd for breaktimes
        
        timersArray.insert(longBreakTime*60, at: indexOfTimersArray)
        arrayForThePercentage.insert(longBreakTime*60, at: indexOfTimersArray)
    }
    
    func whichCycle()->String {
        
        var whichCycle : Double = (Double(indexOfTimersArray)+1)
        if whichCycle == 0 {
            whichCycle = 1
        }
        whichCycle = whichCycle.rounded(.up)
        
        return "\(Int(whichCycle))" + "/\(timersArray.count)"
        
    }
    
    
    func updateArrayOfInputsAndTimersArray() {
        let worktime = arrayOfInput[0]
        let breaktime = arrayOfInput[1]
        let cycles = arrayOfInput[2]
        
        timersArray = setTimers(worktime: worktime, breaktime: breaktime, cycles: cycles)
        indexOfTimersArray = 0
        
    }
    
    func settingsOnDefault() {
        arrayOfInput = [25,5,4,15]
        updateArrayOfInputsAndTimersArray()
    }
    
    // MARK: - SOUND FUNC
    func playSound(sound:String, type:String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            }
            catch {
                print ("Can't play the sound, name or type incorrect")
            }
            
        }
    }
    
    func playRingTone() {
        
        if indexOfTimersArray%2 == 0 {
            self.playSound(sound: "future_sms", type: "mp3")
        } else {
            self.playSound(sound: "transport", type: "mp3")
        }
        
    }
    
    
    // MARK: - NOTIFICATION FOR TIMER
    
    
    
    func setNotification(within: Int) {
        
        let content = UNMutableNotificationContent()
        
        content.title = self.indexOfTimersArray%2 == 0 ? "Focus Timer Buzzing" : "Break Timer Buzzing"
        content.subtitle = self.indexOfTimersArray%2 == 0 ? "take a break" : "time to come back"
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "future_sms.mp3"))
        
        
        if within > 0 { //timerInterval can't be 0 or negative
            
            // show this notification within
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(within), repeats: false)
            
            // choose a random identifier
            let request = UNNotificationRequest(identifier: "timer notification", content: content, trigger: trigger)
            
            // add notification request
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    
    
    func requestNotificationAutorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                DispatchQueue.main.async {
                    self.remidUserToActivateNotification = false
                }
            }
            else if let error = error { print(error.localizedDescription) }
        }
    }
    
    
    // MARK: - BACKGROUND FUNC
    
    func prepareForBackground() {
        if myTimer == nil {
            
            // don't set anithing
            
        } else {
            
            // in this case the timer is activated
            
            setNotification(within: self.timersArray[self.indexOfTimersArray])
            
            // set the timer at
            
            timeDateBackground = Calendar.current.dateComponents([.hour, .minute, .second], from: Date()) //save the time it is now
            
        }
    }
    
    func getSecondsFromSleep()->Int {
        if myTimer == nil {
            
            //  in this case the timer wasn't turn it on
            
            print ("the timer is nil")
            return 0
        } else {
            
            // in this case the timer was activated but the phone is locked so the os have turn it of the timer func; the goal here is to set the timer as it never turn it off counting the diff from prepare for background and this func itself.
            
            
            // check what time it is and check with what time was when i prepare the background
            
            timeDateForeground = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
            let secondPassedFromSleep = Calendar.current.dateComponents([.second], from: timeDateBackground, to: timeDateForeground).second
            
            //calcule again the second of the timer once it is on
            let timerAdjusted = self.timersArray[self.indexOfTimersArray] - secondPassedFromSleep!
            
            
            if timerAdjusted <= 0 { // if the time passed from the sleep is more than the current timer it means the app has to go to the next timer if there is one
                
                if (self.indexOfTimersArray + 1) < self.timersArray.count {
                    self.indexOfTimersArray += 1
                }
                
            } else {
                self.timersArray[self.indexOfTimersArray] = timerAdjusted
                normalTimer += secondPassedFromSleep!
                
            }
            
            if (secondPassedFromSleep != nil) {
                
                print("secondPassedFromSleep", secondPassedFromSleep!)
                return secondPassedFromSleep!
            } else { return 0 }
        }
            
        
    }
    
    
    //MARK: - VIBRATION FUNC
    func classicVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func robustVibration() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    //MARK: - GOAL OBJECTs STUFF
    func calculateTheFutureDate(whitin: String?) -> String {
        let now = Date()
        
        var Ndays = DateComponents()
        
        if  whitin != nil && (Int(whitin!) != nil) { // check if it is a number only
            Ndays.day = Int(whitin!)
            
            let futureDate = Calendar.current.date(byAdding: Ndays, to: now)
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: futureDate!)
            
        } else {
            return "Unkown"
        }
        
        
    }
    
    func renameTheSec (seconds : Int32) -> String {
        
        let days = (seconds / 86400)
        let hours = ((seconds%86400) / 3600) % 3600
        let minutes = ((seconds%3600) % 3600) / 60
        let secondz = ((seconds%3600) % 3600) % 60
        
        var stD = ""
        var stH = ""
        var stM = ""
        var stS = "0s"
        
        if days > 0 {
            stD = String(days) + "d "
            stM = ""
            stS = ""
        }
        
        if hours > 0 {
            stH = String(hours) + "h "
            stS = ""
        }
        if minutes > 0 {
            stM = String(minutes) + "m "
            if days > 0 {
                stM = ""
            }
        }
        if secondz > 0 {
            stS = String(secondz) + "s"
            
            if days > 0 || hours > 0 {
                stS = ""
            }
            
        }
        
        return  stD + stH + stM + stS
    }
    
   //MARK:- COUNT TIMES LAUNCHING APP
    
    func incrementAppRuns() {                   // counter for number of runs for the app. You can call this from App Delegate
        
        let usD = UserDefaults()
        let runs = getRunCounts() + 1
        usD.setValuesForKeys([runIncrementerSetting: runs])
        usD.synchronize()
        
    }
    func getRunCounts () -> Int {               // Reads number of runs from UserDefaults and returns it.
        
        let usD = UserDefaults()
        let savedRuns = usD.value(forKey: runIncrementerSetting)
        
        var runs = 0
        if (savedRuns != nil) {
            
            runs = savedRuns as! Int
        }
        
        print("Run Counts are \(runs)")
        return runs
        
    }
    
    
    
    
}

// MARK: - 
@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    // T is the type of the thing itself
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

public extension View {
    func dismissKeyboardOnTap() -> some View {
        modifier(DismissKeyboardOnTap())
    }
}

public struct DismissKeyboardOnTap: ViewModifier {
    public func body(content: Content) -> some View {
        #if os(macOS)
        return content
        #else
        return content.gesture(tapGesture)
        #endif
    }
    
    private var tapGesture: some Gesture {
        TapGesture().onEnded(endEditing)
    }
    
    private func endEditing() {
        UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .map {$0 as? UIWindowScene}
            .compactMap({$0})
            .first?.windows
            .filter {$0.isKeyWindow}
            .first?.endEditing(true)
    }
}
