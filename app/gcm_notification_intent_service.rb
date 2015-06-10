class GCMNotificationIntentService < Android::App::IntentService
  NOTIFICATION_ID = 1
  TAG = "GCMNotificationIntentService"
  def initialize
    super
  end
  
  def onHandleIntent(intent)
        puts "coming into gcm notification$$$$$$$$$$$"
        extras = intent.getExtras
        puts extras
        gcm = Com::Google::Android::Gms::Gcm::GoogleCloudMessaging.getInstance(self)
        messageType = gcm.getMessageType(intent)
        #if !extras.isEmpty
          if Com::Google::Android::Gms::Gcm::GoogleCloudMessaging::MESSAGE_TYPE_SEND_ERROR.equals(messageType)
            sendNotification("Send error: " + extras.toString())
          elsif Com::Google::Android::Gms::Gcm::GoogleCloudMessaging::MESSAGE_TYPE_DELETED.equals(messageType)
            sendNotification("Deleted messages on server: "+ extras.toString())
          elsif Com::Google::Android::Gms::Gcm::GoogleCloudMessaging::MESSAGE_TYPE_MESSAGE.equals(messageType)
            i = 0
            while i < 3
              Java::Lang::Thread.sleep(5000)
              i = i+1
            end
            sendNotification(extras.get(Config::MESSAGE_KEY))
          #end
        end
        GcmBroadcastReceiver.completeWakefulIntent(intent)
      end
      
      def sendNotification(msg)
        mNotificationManager = self.getSystemService(Android::Content::Context::NOTIFICATION_SERVICE)
        contentIntent = Android::App::PendingIntent.getActivity(self, 0, Android::Content::Intent.new(self, MainActivity.class), 0)
        mBuilder = Android::Support::V4::App::NotificationCompat::Builder.new(self)
        #layout = resources.getIdentifier('ensource_launcher', 'drawable', packageName)
        puts R::Drawable::Bank
        mBuilder.setSmallIcon(R::Drawable::Bank)  #(layout)
        mBuilder.setContentTitle("ENSource")
        mBuilder.setStyle(Android::Support::V4::App::NotificationCompat::BigTextStyle)
        mBuilder.bigText(msg)
        mBuilder.setContentText(msg)
        mBuilder.setDefaults(Notification::DEFAULT_LIGHTS)
        mBuilder.setContentIntent(contentIntent)
        mNotificationManager.notify(NOTIFICATION_ID, mBuilder.build())
      end
end