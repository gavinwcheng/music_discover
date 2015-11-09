module OmniauthMock
  def mock_auth_hash
    OmniAuth.config.mock_auth[:spotify] = {
      'provider' => 'spotify',
      'id' => 'testing',
      'email' => 'testing@testing.com'
    }
  end
end
