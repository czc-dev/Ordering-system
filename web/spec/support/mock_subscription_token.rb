module MockSubscriptionToken
  def self.call
    Base64.encode64(
      {
        'endpoint' => 'https://fcm.googleapis.com/fcm/send/cMgUgqERq2k:APA91bHaVpIOkUwTmygDsxJryxLJNrv9awD5uR2X3MmH_LKhvAdTdPNbPxOcOV7NtGGDgMz2D5wC4jqGaaxCNH_mKJkAXSQm4m6mbO3L8uXyi_zzK015wqL-Cd6Gjd39i5oWO8L8JtVp',
        'keys' => {
          'p256dh' => 'BJoGR9D5AWn3hyFyf9zB-29PNB7U8TvTt7bH56DzmQKh0PbIt2HHOQrJJi_6vO54Vw4kzgMuNl9ilwgC--JNIIU',
          'auth' => 'RPyCggnQAec6q9S1jrT0IQ'
        }
      }.to_json
    )
  end
end
