class MainActivity < Android::App::Activity
  MyPREFERENCES = "MyPreferences"
  GCMNOTIFICATION = "gcm"
  APP_VERSION = "appVersion"
  def onCreate(savedInstanceState)
    super
    #layout
    layout = resources.getIdentifier('activity_main', 'layout', packageName)
    self.contentView = layout
    
    gcm_button = findViewById(R::Id::Get_regid)
    gcm_button.onClickListener = self

  end

  def onClick(view)
    @regId = registerGCM
  end
  
  def registerGCM
      registerInBackground
  end
  
  def registerInBackground
    puts getApplicationContext
    gcm_async_task = GcmAsyncTask.new(getApplicationContext)
    url = [nil, nil, nil]
    gcm_async_task.execute(url)
  end
  
end