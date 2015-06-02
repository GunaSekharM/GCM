class GcmBroadcastReceiver < Android::Support::V4::Content::WakefulBroadcastReceiver
  def onReceive(context, intent)
    if (intent.getAction.equals("Com::Google::Android::C2dm::Intent::RECEIVE"))
      comp = new ComponentName(context.getPackageName, GCMNotificationIntentService.class.getName)
      startWakefulService(context, intent.setComponent(comp))
      setResultCode(Android::App::Activity::RESULT_OK)
    end
  end
end