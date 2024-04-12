//
//  AppSetting.swift
//  Outread
//
//  Created by Dhruv Sirohi on 11/3/2024.
//

import SwiftUI

struct AppSettingsView: View {
    @AppStorage("notificationsEnabled") var notificationsEnabled: Bool = false
    @AppStorage("darkModeEnabled") var darkModeEnabled: Bool = false

    var body: some View {
        Form {
            Toggle("Enable Notifications", isOn: $notificationsEnabled)
            Toggle("Enable Dark Mode", isOn: $darkModeEnabled)
        }
        .navigationTitle("App Settings")
    }
}
