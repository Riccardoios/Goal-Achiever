//
//  foocusTitleView.swift
//  Foocus
//
//  Created by Riccardo Carlotto on 26/04/2020.
//  Copyright © 2020 Riccardo Carlotto. All rights reserved.
//

import SwiftUI

struct FoocusTitleView: View {
    var timerVM = TimerViewModel()
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Goal.entity(), sortDescriptors: [
        NSSortDescriptor(key: #keyPath(Goal.dateEdited), ascending: false)]//, predicate: NSPredicate(format: "id == %@", idOfTheSelected)
        // here be able to put insetad of yo a idd the one i saved in the timerVM
    ) var goals: FetchedResults<Goal> // from the oldest to the newst
    
    
    var body: some View {
        Text(changeTitle())
            .font(.system(size: timerVM.firstSizeFont * myCoef, weight: .regular ))
            .lineLimit(1)
            .minimumScaleFactor(0.4)
            .foregroundColor(Color(timerVM.firstColorText))
            .modifier(ShadowLightModifier())
            .padding(.horizontal)
        
    }
    
    func changeTitle()-> String {
        // instead of [0] i want to go to the id that is equal to the property of timervm
        // for in in loop that loop all the id and gives back the one that is equal to the id if there isn't is gonna give back the string foocus
        var result = "Focus"
        
        if self.timerVM.indexOfTimersArray % 2 == 0 {
            
            if self.goals.first != nil{
                result = self.goals.first!.image! + " " + self.goals.first!.title!
            } // give the last goal as result
            
        } else {
            result = "Break"
        }
        
        return result
    }
}
