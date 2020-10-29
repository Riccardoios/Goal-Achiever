//
//  FeedbackView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 09/09/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//


// maybe put a percentage as a semi ringview on top of the emoji which is goanna be the percentage of the funcion

import SwiftUI

struct FeedbackView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [
        NSSortDescriptor(key: #keyPath(Goal.dateEdited), ascending: false)
    ]) var goals: FetchedResults<Goal> // from the oldest to the newst
    @EnvironmentObject var timerVM: TimerViewModel
    @State var emoji = "😄"
    @State var text = "Setting goals and working to achieving them helps us define what we truly want in life."
    var last7days = 3.0 // for examples purpuses: last 7 days how many session the user had
    
    let arrNogoals = ["Goals give us a roadmap to follow.", "Goals are a great way to hold ourselves accountable, even if we fail.",  "Setting goals and working to achieving them helps us define what we truly want in life.", "Setting goals also helps us prioritize things."] //case no gaol will give emoji that says something about you inspire to have a goal
    @State var progress: Float = 0.5
    
    var body: some View {
        //            VStack{
        //
        //
        //
        //                Spacer().frame(height:20)
        
//        ZStack{
            
//            AntiRilievoView(width: 330, height: 270, cornerRadious: 60)
            
            VStack{
                
                Text(emoji)
                    .modifier(ShadowLightModifier())
                    .font(.system(size: 120))
                    .padding(.bottom, -25)
                
                 Spacer().frame(height:20)
            
                ZStack{
                
                AntiRilievoView(width: 330, height: 130, cornerRadious: 60)
                    
                Text(text)
                    .modifier(ShadowLightModifier())
                    .foregroundColor(Color(timerVM.secondColorText))
                    .font(.system(size: timerVM.secondSizeFont))
                    .frame(width:310, height: 100)
                    
                }
            }
        }
        
        //                Spacer().frame(height:20)
        
        //                ProgressBar(value: $progress)
        //                .frame(height:25)
        //                .padding(.horizontal, 20)
        
        
        //                Spacer()
        //        }
        
        
//    }
    
    func changeEmoji() {
        // only consisntecy: so you have to work the same ammount of times of the week said as you plan to it will be happy
        // if you work half or more a bit happy
        // if less than half serious
        // less than 25% unhappy,
        // 0 very sad
        
        //1. get number of days true in a week
        //2. calcule the fraction of it
        //25 minutes is ok for 1 session to be completed
        
        var hundredPercent = 0.0 //number of days in a week the user setted
        
        if goals.isEmpty {
            emoji = "😎"
            text = arrNogoals.randomElement()!
        } else {
            let goalSelected = goals.first!
            
            for day in [goalSelected.monday, goalSelected.tuesday, goalSelected.wednesday, goalSelected.thursday, goalSelected.friday, goalSelected.saturnday, goalSelected.sunday] {
                
                if day {
                    hundredPercent += 1.0
                }
            }
            
            let workingCoef = hundredPercent / last7days
            
            switch workingCoef {
                
            case 0..<0.3:
                emoji = "😐"
                
            case 0.3..<0.6:
                emoji = "🙂"
                
            case 0.6..<0.9:
                emoji = "😄"
                
            case 1:
                emoji = "🤩"
                
                
                
            default:
                emoji = "😎"
                text = arrNogoals.randomElement()!
            }
            
            
            
            
        }
        
        
        
        
        
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView().environmentObject(TimerViewModel())
    }
}
