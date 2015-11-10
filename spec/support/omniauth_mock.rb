module OmniauthMock
  def mock_omniauth_hash
    OmniAuth.config.mock_auth[:spotify] = {
      'provider' => 'spotify',
      'email' => 'testing@testing.com',
      'id' => 'test_username',
      'display_name' => 'test_display_name',
      'images' => [{'url' => 'test_url'}]
    }
  end

  def mock_omniauth_invalid_credentials
    OmniAuth.config.mock_auth[:spotify] = :invalid_credentials
  end
end
