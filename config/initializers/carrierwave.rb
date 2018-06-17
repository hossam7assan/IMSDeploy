CarrierWave.configure do |config|
  config.fog_provider = 'fog/google'                        # required
  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     'GOOGTC5QA3TGJTT5C6GNFFU6',
    google_storage_secret_access_key: '0lgh9cpHcxxdvZzFS/rPBNJ5mdv9X/QxmCfCF9Id'
  }
  config.fog_directory = 'cv_dir'
end