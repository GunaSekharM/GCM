class GcmBroadcastReceiver < Android::Content::BroadcastReceiver
  
  def onReceive(context, intent)
    puts "coming into broadcastReceiver&&&&&&&&&&&&&"
    if (intent.getAction.equals("com.google.android.c2dm.intent.RECEIVE"))
      puts "coming into broadcastReceiver"
      puts GCMNotificationIntentService.class.getName
      puts context.getPackageName
      comp = Android::Content::ComponentName.new(context.getPackageName, GCMNotificationIntentService.class.getName)
      Android::Support::V4::Content::WakefulBroadcastReceiver.startWakefulService(context, intent.setComponent(comp))
      setResultCode(Android::App::Activity::RESULT_OK)
    end
  end