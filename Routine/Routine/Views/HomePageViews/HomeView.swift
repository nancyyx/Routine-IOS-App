//
//  HomeView.swift
//  Routine
//
//  Created by Dajun Xian on 10/1/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        
        VStack(spacing: 0) {
            CurrentView()
            ListView()
            Spacer()
        }
        
        
        //.statusBar(hidden: true)  //mindful!!
          //maybe
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserViewModel())
    }
}
