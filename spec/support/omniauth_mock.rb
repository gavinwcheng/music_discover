module OmniauthMock
  def mock_omniauth_hash
    OmniAuth.config.mock_auth[:spotify] = {
      'provider' => 'spotify',
      'email' => 'testing@testing.com',
      'id' => 'test_username',
      'display_name' => 'test_display_name',
      'images' => [{'url' => 'test_user_url'}]
    }
  end
end
