class GcmAsyncTask < Android::Os::AsyncTask
  GCMNOTIFICATION = "gcm"
  MyPREFERENCES = "prefs"
  def initialize(context, activity)
    @context = context
    @activity = activity
  end
  
  def doInBackground(param)
    gcm = Com::Google::Android::Gms::Gcm::GoogleCloudMessaging.getInstance(@context)
    regId = gcm.register([Java::Lang::String.new(Config::GOOGLE_PROJECT_ID)])
    puts "regId: "+regId
    httpclient = Org::Apache::Http::Impl::Client::DefaultHttpClient.new
    url = "http://sumerudevserver.cloudapp.net/ENSourcePrototype/DeviceAPI/AddDeviceRegistrations?deviceRegistrationID="+regId
    httppost = Org::Apache::Http::Client::Methods::HttpPost.new(url)
    response = httpclient.execute(httppost)
    entity = response.getEntity
    puts entity
    regId
  end
  
  def onPostExecute(regId)
    @activity.storeRegId(regId)
    #Android::Widget::Toast.makeText(@context, "Registered with GCM Server." + msg, Android::Widget::Toast::LENGTH_LONG).show  
  end
end