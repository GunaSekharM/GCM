# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/android'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'GCM'
  app.api_version = '17'
  app.package="com.yourcompany.gcm"
  app.main_activity="MainActivity"
  app.permissions += [:internet, "android.permission.READ_EXTERNAL_STORAGE", "android.permission.SEND_SMS", "android.permission.GET_ACCOUNTS", "android.permission.VIBRATE", "android.permission.ACCESS_NETWORK_STATE", "android.permission.WAKE_LOCK", "com.yourcompany.gcm.permission.C2D_MESSAGE", "com.google.android.c2dm.permission.RECEIVE"]
  #app.support_libraries << 'google-play-services'
  #app.support_libraries << 'android-support-v4'
  app.vendor_project :jar => "vendor/android-support-v4.jar"
  app.vendor_project :jar => "vendor/google-play-services.jar"
  app.vendor_project :jar => "vendor/gcm.jar"
  permission = app.manifest.add_child('permission',
     {"android:name" => "com.yourcompany.gcm.permission.C2D_MESSAGE",
       "android:protectionLevel" => "signature"})
       receiver = app.manifest.child('application').add_child('receiver', {
         "android:name" => "com.yourcompany.gcm.GcmBroadcastReceiver",
         "android:exported" => "true",
         "android:permission" => "com.google.android.c2dm.permission.SEND" })
         filter = receiver.add_child("intent-filter")
         filter.add_child("action", { "android:name" => "com.google.android.c2dm.intent.RECEIVE" })
         filter.add_child("action", { "android:name" => "com.google.android.c2dm.intent.REGISTRATION" })
         filter.add_child("category", { "android:name" => "com.yourcompany.gcm" })
         app.manifest.child('application').add_child('service', { "android:name" => "com.yourcompany.gcm.GCMNotificationIntentService" })
end
