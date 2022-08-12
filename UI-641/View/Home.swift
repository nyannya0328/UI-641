//
//  Home.swift
//  UI-641
//
//  Created by nyannyan0328 on 2022/08/12.
//

import SwiftUI

struct Home: View {
    @State var tools: [Tools] = [
            .init(icon: "scribble.variable", name: "Scribble", color: .purple),
            .init(icon: "lasso", name: "Lasso", color: .green),
            .init(icon: "plus.bubble", name: "Comment", color: .blue),
            .init(icon: "bubbles.and.sparkles.fill", name: "Enhance", color: .orange),
            .init(icon: "paintbrush.pointed.fill", name: "Picker", color: .pink),
            .init(icon: "rotate.3d", name: "Rotate", color: .indigo),
            .init(icon: "gear.badge.questionmark", name: "Settings", color: .yellow)
        ]
    
    @State var activeTool : Tools?
    @State var startedToolPostion : CGRect = .zero
    var body: some View {
        VStack(alignment: .leading){
            
            
            VStack(alignment: .leading) {
                
                ForEach($tools){$tool in
                    
                    ToolView(tool: $tool)
                    
                    
                }
                
            }
            
            .padding(.horizontal,10)
            .padding(.vertical,12)
            .background{
             
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .fill(
                    
                        .shadow(.drop(color:.black.opacity(0.1), radius: 5,x: 5,y: 5)).shadow(.drop(color:.black.opacity(0.05),  radius: -5,x: -5,y: -5))
                    
                    
                    
                    )
                 .frame(width: 65)
                  .frame(maxWidth: .infinity,alignment: .leading)
            }
            .coordinateSpace(name: "AREA")
            .gesture(
            
            
                DragGesture(minimumDistance: 5)
                    .onChanged({ value in
                        
                        guard let firstTool = tools.first else{return}
                        
                        
                        if startedToolPostion == .zero{
                            startedToolPostion = firstTool.toolPostion
                            
                        }
                        
                        let location = CGPoint(x: startedToolPostion.midX, y: value.location.y)
                        
                        
                        if let index = tools.firstIndex(where: { tool in
                            
                            tool.toolPostion.contains(location)
                            
                        }),activeTool?.id != tools[index].id{
                            
                            
                            
                            
                            withAnimation(.interpolatingSpring(stiffness: 250, damping: 30)){
                                
                                
                                
                                activeTool = tools[index]
                                
                            }
                        }
                        
                        
                        
                        
                    
                        
                        
                    })
                    .onEnded({ value in
                        
                        startedToolPostion = .zero
                        activeTool = nil
                    })
            )
          
            
        }
        .padding(15)
        .padding(.top)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .topLeading)
    }
    @ViewBuilder
    func ToolView(tool : Binding<Tools>)->some View{
        
        HStack(spacing:0){
            
            Image(systemName: tool.icon.wrappedValue)
                .font(.title2)
             .frame(width: 45,height: 45)
             .padding(.leading,activeTool?.id == tool.id ? 15 : 0)
             .background{
              
                 
                 GeometryReader{proxy in
                     
                     let frame = proxy.frame(in: .named("AREA"))
                     
                     
                     Color.clear
                     
                         .preference(key : RectKey.self ,value: frame)
                         .onPreferenceChange(RectKey.self) { value in
                             
                             tool.wrappedValue.toolPostion = value
                             
                         }
                 }
             }
            
            if activeTool?.id == tool.id{
                
                Text(tool.name.wrappedValue)
                    .font(.title2)
                
                
            }

        }
        .background{
         
            RoundedRectangle(cornerRadius: 10,style: .continuous)
                .fill(tool.color.wrappedValue.gradient)
        }
        .offset(x:activeTool?.id == tool.wrappedValue.id ? 60 : 0)
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RectKey : PreferenceKey{
    
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
