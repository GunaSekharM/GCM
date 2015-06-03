class MainActivity < Android::App::Activity
  MyPREFERENCES = "prefs"
  def onCreate(savedInstanceState)
    super
    #layout
    layout = resources.getIdentifier('activity_main', 'layout', packageName)
    self.contentView = layout
    
    gcm_button = findViewById(R::Id::Get_regid)
    gcm_button.onClickListener = self

  end

  def onClick(view)
    @sharedpreferences = getSharedPreferences(MyPREFERENCES, Android::Content::Context::MODE_PRIVATE)
    regId_value = @sharedpreferences.getString("device_registration_id", nil)
    puts regId_value
    if regId_value
      registerInBackground
    end
  end
  
  def registerInBackground
    gcm_async_task = GcmAsyncTask.new(getApplicationContext, self)
    url = [nil, nil, nil]
    gcm_async_task.execute(url)
  end
  
  def storeRegId(regID)
    puts regID
    editor = @sharedpreferences.edit
    editor.putString("device_registration_id", regID)
    editor.commit
  end
  
end