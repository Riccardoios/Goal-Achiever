//
//  GraphicChartView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 10/09/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//


import SwiftUI
import StoreKit

var alreadyAskedForReview:Bool = false

struct TrackView: View {
    
    @EnvironmentObject var timerVM : TimerViewModel
    @EnvironmentObject var subManager: SubscriptionManager
    
    @Binding var showPlanView: Bool
    @Binding var showDoView: Bool
    @Binding var showChartsView: Bool
    @Binding var showSettingsView: Bool
    @Binding var showPayWallView: Bool
    
    //emoji and motivation views
    var emoji = "😄"
    
    var score = 5
    
    // Last 7 days chart
    var values:[Float] = [0.0, 1, 0.3, 0.4, 0.5, 0.6, 0.7]
    var tagsX = ["M", "Tu", "We", "Th", "Fr", "Sa", "Su"]
    var tagsY:[Int32] = [(25*60)/4, (25*60)/2, 1125, 25*60] //["25%","50%","75%", "100%"] of a session of 25 min
    
    //total time last 7 days chart
    var ammountOfTimeLast7Days:Int32 = 0
    var coef7days = 1.0
    //your most worked goal
    var sortedTitles = [String]()
    var sortedSums = [Int32]()
    var sortedImages = [String]()
    
    
    var body: some View {
        
        ScrollView{
            
            LazyVStack(spacing:25) {
                
                // MARK: - TITLE VIEW
                
                    FoocusTitleView(isTomatoTimer: .constant(false))
                    
                    Text("Statistics and Feedback")
                        .foregroundColor(Color(timerVM.firstColorText))
                        .font(.system(size: timerVM.secondSizeFont))
                        .modifier(ShadowLightModifier())
                
                
                
                // MARK: - EMOJI AND RATING VIEW
                Group{
                    
                    Text(emoji)
                        .modifier(ShadowLightModifier())
                        .font(.system(size: 120))
                    
                    
                    
                    RatingView(rating: .constant(score))
                        .modifier(ShadowLightModifier())
                        .padding(.bottom)
                    //                        .onAppear{
                    //                            if score >= 4 {
                    //                                //request review
                    //                                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    //                                    SKStoreReviewController.requestReview(in: scene)
                    //                                }
                    //                            }
                    //                        }
                    
                }
                
                // MARK: - MOTIVATION QUOTE
                Group {
                    
//                    ZStack{
                        
//                        AntiRilievoView(width: screen.width - 50, height: UIDevice.current.hasNotch ? 220 : 190, cornerRadius: 50)
                        
                        
                        Text(timerVM.motivationQuote)
                            .foregroundColor(Color(timerVM.secondColorText))
                            .font(.system(size: UIDevice.current.hasNotch ? 22 : 19 ))
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(nil)
                            .frame(width: screen.width - 75)
                            .frame(minHeight:100)
                            .modifier(ShadowLightModifier())
//                    }
                }
                //MARK: - LAST SEVEN DAYS CHARTS
                
                Group {
                    Text("Your last 7 days")
                        .foregroundColor(Color(timerVM.firstColorText))
                        .font(.system(size: timerVM.firstSizeFont / 1.5))
                        .modifier(ShadowLightModifier())
                        .padding(.top)
                    
                    ZStack{
                        
//                        AntiRilievoView(width: screen.width - 30, height: 250, cornerRadius: 30)
                        
                        HStack {
                            
                            VStack{
                                
                                Text("\(timerVM.renameTheSec(seconds: tagsY[3]))  -")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(self.timerVM.firstColorTextDarker))
//                                    .modifier(ShadowLightModifier())
                                
                                Spacer().frame(height:22)
                                
                                Text("\(timerVM.renameTheSec(seconds: tagsY[2]))  -")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(self.timerVM.firstColorTextDarker))
//                                    .modifier(ShadowLightModifier())
                                
                                Spacer().frame(height:22)
                                
                                Text("\(timerVM.renameTheSec(seconds: tagsY[1]))  -")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(self.timerVM.firstColorTextDarker))
//                                    .modifier(ShadowLightModifier())
                                
                                
                                Spacer().frame(height:22)
                                
                                Text("\(timerVM.renameTheSec(seconds: tagsY[0]))  -")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(self.timerVM.firstColorTextDarker))
//                                    .modifier(ShadowLightModifier())
                                
                                Spacer()
                                
                                Spacer().frame(height:25) //same height of the tag
                            }
                            .frame(height:200) //same height as columView
                            .padding(.trailing, -10)
                            
                            //   ForEach(Array(zip(values, tagsX)), id: \.1) { item in
                            //
                            //                                ColumView(value: .constant(item.0), tag: .constant(item.1))
                            
                            ForEach(0..<values.count, id: \.self) { i in
                                
                                ColumView(value: .constant(self.values[i]), tag: .constant(self.tagsX[i]))
                                
                            }
                            
                            //                            }
                        }
                        .blur(radius: subManager.subscriptionStatus ? 0 : 7)
                        
                        if subManager.subscriptionStatus == false {
                            PremiumOnlyView(width:screen.width - 30, height: 250, opacity: 0.6, cornerRadius: 30)
                                .onTapGesture{
                                    self.showPayWallView = true
                                    self.showSettingsView = false
                                    self.showPlanView = false
                                    self.showDoView = false
                                    self.showChartsView = false
                                    
                                }
                            
                        }
                        
                    }
                }
                // MARK: - TOTAL TIME LAST 7 DAYS
                Group {
                    
                    Text("Total time last 7 days")
                        .foregroundColor(Color(timerVM.firstColorText))
                        .font(.system(size: timerVM.firstSizeFont/1.5))
                        .modifier(ShadowLightModifier())
                        .padding(.top)
                    
                    ProgressBar(value: .constant(coef7days), label: .constant(timerVM.renameTheSec(seconds: ammountOfTimeLast7Days)))
                        .frame(height:60)
                        .padding(.horizontal)
                    
                }
                // MARK: - YOUR MOST WORKED GOALS
                Group{
                    
                    Text("Your most worked goals")
                        .foregroundColor(Color(timerVM.firstColorText))
                        .font(.system(size: 30))
                        .modifier(ShadowLightModifier())
                        .padding(.top)
                    
//                    ZStack{
                        
//                        AntiRilievoView(width: screen.width - 30, height: 250, cornerRadius: 30)
                        
                        
                        VStack (alignment: .leading, spacing: 10) {
                            ForEach(0..<sortedTitles.count, id: \.self) { ind in
                                
                                HStack {
                                    
                                    Text("\(ind+1). ")
                                        .foregroundColor(Color(self.timerVM.firstColorText))
                                        .modifier(ShadowLightModifier())
                                    
                                    Text("\(self.sortedImages[ind])")
                                        .foregroundColor(Color(self.timerVM.firstColorText))
                                        .modifier(ShadowLightModifier())
                                    
                                    
                                    Text(self.sortedTitles[ind])
                                        .foregroundColor(Color(self.timerVM.firstColorText))
                                        .modifier(ShadowLightModifier())
                                    
                                    
                                    Spacer()
                                    
                                    Text("\(self.timerVM.renameTheSec(seconds: self.sortedSums[ind]))")
                                        .foregroundColor(Color(self.timerVM.firstColorText))
                                        .modifier(ShadowLightModifier())
                                }
                                
                            }
                            Spacer()
                        }
                        .frame(width:screen.width - 150, height: 250)
//                    }
                    
                }
            }
        }
        
        
    }
    
    init(goals: FetchedResults<Goal>, sessions: FetchedResults<Sessions>,  showPlanView: Binding<Bool>, showDoView: Binding<Bool>, showChartsView: Binding<Bool>, showSettingsView: Binding<Bool>, showPayWallView: Binding<Bool>) {
        
        self._showPlanView = showPlanView
        self._showDoView = showDoView
        self._showChartsView = showChartsView
        self._showSettingsView = showSettingsView
        self._showPayWallView = showPayWallView
        
        let firstGoal = goals.first?.title ?? "the impossible title is here" //too long to be real
        
        var sevenDays = [Int32]()
        let todayAt00_00 = Calendar.current.startOfDay(for: Date()) // add that this is the first second of today
        
        for i in 0...6 {
            let day = Calendar.current.date(byAdding: .day, value: -i, to: todayAt00_00)!
            
            let startday = Calendar.current.startOfDay(for: day)
            let endDay = Calendar.current.date(byAdding: .day, value: 1, to: startday)!
            var sumOfDay:Int32 = 0
            
            //for the day name
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EE"
            let dayName = dateFormatter.string(from: day)
            
            let a = dayName.map {$0}
            let shortDayName = String(a[0])+String(a[1])
            tagsX[i] = shortDayName
            
            for s in sessions {
                
                if s.title == firstGoal {
                    if s.date! > startday && s.date! < endDay {
                        
                        sumOfDay += s.secondsWorked
                        
                    }
                }
            }
            sevenDays.append(sumOfDay)
        }
        sevenDays = sevenDays.reversed()
        
        
        tagsX = tagsX.reversed()
        
        ammountOfTimeLast7Days = sevenDays.reduce(0, +)
        
        let maximum = sevenDays.max()
        
        values = []
        
        if maximum != 0 {
            for elem in sevenDays {
                values.append(Float(elem)/Float(maximum!))
            }
            
            
            if maximum != nil {
                var ind = 0
                let arrDividend:[Float] = [4.0, 2.0, 1.333333, 1.0]
                for dividend in arrDividend {
                    let argument = Float(maximum!)/dividend
                    
                    self.tagsY[ind] = Int32(argument)
                    ind+=1
                }
                
            }
            
        } else {
            values = [0, 0, 0, 0, 0, 0, 0]
        }
        
        //for the feed and the rating:
        let arrIdealWeek = [goals.first?.sunday, goals.first?.monday, goals.first?.tuesday, goals.first?.wednesday, goals.first?.thursday, goals.first?.friday, goals.first?.saturnday]
        
        var nDaysToWork = 0.0
        
        //get the nDaysToWork setted from the user
        for day in arrIdealWeek {
            if day == true {
                nDaysToWork+=1
                
            }
        }
        
        var workedDays = 0.0
        
        
        // count how many days you worked in the last week (values)
        for ammountSecsDay in values {
            if ammountSecsDay > 0.0 { //25 minutes
                workedDays += 1
            }
        }
        
        
        // if the user set ammount of days to work
        if nDaysToWork > 0 {
            //get a coeficent:
            coef7days = workedDays/nDaysToWork
            
        } else { // in case the user doesn't set an ammount set as it should work 3 days
            
            coef7days = workedDays/3.0
        }
        
        switch coef7days {
        case 1...:
            
            if !alreadyAskedForReview {
                alreadyAskedForReview = true
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
                
            }
            
            score = 5
            emoji = "🤩"
            
        case 0.8..<1:
            
            if !alreadyAskedForReview {
                alreadyAskedForReview = true
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
                
            }
            
            score = 4
            emoji = "😎"
            
        case 0.6..<0.8:
            score = 3
            emoji = "😄"
            
        case 0.4..<0.6:
            score = 2
            emoji = "🙂"
            
        case 0.2..<0.4:
            score = 2
            emoji = "😐"
            
        case 0..<0.2:
            score = 1
            emoji = "😔"
            
        default:
            score = 1
            emoji = "😔"
        }
        
        //MARK: - LOGIC YOUR MOST WORKED GOALS CHART
        
        var arrOfGoalsTitles = [String]()
        var arrOfSumsEachGoal = [Int32]()
        var arrOfGoalsImages = [String]()
        
        for g in 0..<goals.count {
            let goalTitle = goals[g].title
            arrOfGoalsTitles.insert(goalTitle!, at: g)
            
            let goalImage = goals[g].image
            arrOfGoalsImages.insert(goalImage!, at: g)
            
            
            var sumOfGoal = Int32()
            var arrOfSecs = [Int32]()
            
            for i in 0..<sessions.count {
                if sessions[i].title == goalTitle {
                    let seriesOfSecs = sessions[i].secondsWorked
                    arrOfSecs.append(seriesOfSecs)
                }
            }
            sumOfGoal = arrOfSecs.reduce(0,+)
            arrOfSumsEachGoal.append(sumOfGoal)
        }
        
        sortedSums = arrOfSumsEachGoal.sorted(by:>)
        
        for i in 0..<arrOfSumsEachGoal.count {
            let indexToMove = arrOfSumsEachGoal.firstIndex(of: sortedSums[i])
            arrOfSumsEachGoal[indexToMove!] = -9
            sortedTitles.append(arrOfGoalsTitles[indexToMove!])
            sortedImages.append(arrOfGoalsImages[indexToMove!])
        }
        
        
        if sortedTitles.count > 7 {
            sortedTitles.removeSubrange(7...)
            sortedImages.removeSubrange(7...)
            sortedSums.removeSubrange(7...)
        }
        
        
    }
    
}

//struct GraphicChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        GraphicChartView().environmentObject(TimerViewModel())
//    }
//}
