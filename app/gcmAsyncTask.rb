class GcmAsyncTask < Android::Os::AsyncTask
  GCMNOTIFICATION = "gcm"
  def initialize(context)
    @context = context
  end
  
  def doInBackground(param)
    msg = ""
    regId = ""
    gcm = Com::Google::Android::Gms::Gcm::GoogleCloudMessaging.getInstance(@context)
    # register method is not recognizing by rubyMotion
    regId = gcm.register(Java::Lang::String.new(Config::GOOGLE_PROJECT_ID))
    msg = "Device registered, registration ID= "+regId
    msg
  end
  
  def onPostExecute(msg)
    puts "Coming here&&&&&&&&&&&&&"
    Android::Widget::Toast.makeText(@context, "Registered with GCM Server." + msg, Android::Widget::Toast::LENGTH_LONG).show  
  end
end