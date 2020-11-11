//
//  LaunchView.swift
//  Goals
//
//  Created by Riccardo Carlotto on 10/11/2020.
//
// check the wave animatio that i transform in a rectangule let's see if to keep it or come back to a circle
import SwiftUI

struct LaunchView: View {
    
    @Binding var showHome: Bool
    @State var circlePressed = false
    @State var showPreferencesView = false
    @State var animate = false
    @State var showIndications = false
    
    var body: some View {
        
        ZStack {
            
            Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00))
                .ignoresSafeArea(.all)
                .onTapGesture {
                    showHomeInDelay()
                }
            
            VStack{
                Spacer()
                Text("tap anywhere to start")
                    .opacity(showIndications ? 1 : 0)
                    .animation(.linear)
                    .onAppear{
                        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in                               self.showIndications = true
                        }
                    }
            }
            
            
            WaveAnimationView(animate: animate, lineWidth: 5, repetitions: 100)
                .frame(width: 180, height: 180)
                .offset(x: -2.5, y: -34.5)
                .onAppear{
                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in                               self.animate = true
                    }
                }
            
            
            
            VStack{
                
                Circle()
                    .foregroundColor(Color(#colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)))
                    .mask(Image("goal")
                            .resizable()
                            .padding(9)
                            .aspectRatio(contentMode: .fill))
                    .frame(width: 200, height: 200)
                    .modifier(ShadowLightModifier())
                    .opacity(circlePressed ? 0 : 1)
                    .opacity(animate ? 1 : 0)
                    .offset(x:7, y:4)
                    .animation(.linear(duration: 1))
                    .onTapGesture {
                        showHomeInDelay()
                    }
                
                
                Text("Goal Achiever")
                    .font(.system(size: 40, weight:.semibold))
                    .foregroundColor(Color(#colorLiteral(red: 0.2393075824, green: 0.6728859544, blue: 0.9679804444, alpha: 1)))
                    .modifier(ShadowLightModifier())
                    .offset(y: -35)
                    .opacity(circlePressed ? 0 : 1)
                    .opacity(animate ? 1 : 0)
                    .animation(.linear(duration: 1))
                    .onTapGesture {
                        showHomeInDelay()
                    }
                
                
            }
            //circle animation
            
            Circle()
                .frame(width: circlePressed ? 2000 : 1, height: circlePressed ? 2000 : 1)
                .foregroundColor(Color(#colorLiteral(red:0.89, green:0.90, blue:0.93, alpha:1.00)))
                .modifier(ShadowLightModifier())
                .animation(.easeInOut(duration: 5.0))
                .offset(x: -2.5, y: -34.5)
                

            
            
        }
        
    }
    
    func showHomeInDelay() {
        self.circlePressed = true
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in                              self.showHome = true
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showHome: .constant(false))
    }
}
