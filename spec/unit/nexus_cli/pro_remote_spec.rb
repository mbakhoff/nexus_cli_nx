require 'nexus_cli'

describe NexusCli::ProRemote do
  let(:remote) do
    NexusCli::ProRemote.new(
      'url' => 'http://localhost:8081/nexus',
      'repository' => 'releases',
      'username' => 'admin',
      'password' => 'admin123'
    )
  end

  it "gives you errors when you attempt to get an artifact's custom info and don't give a valid artifact name" do
    expect {remote.get_artifact_custom_info("com.something:something")}.to raise_error(NexusCli::ArtifactMalformedException)
  end

  it "gives you errors when you attempt to get an artifact's custom info and it cannot be found" do
    expect_any_instance_of(HTTPClient).to receive(:get).and_raise(NexusCli::ArtifactNotFoundException)
    expect {remote.get_artifact_custom_info("com.something:something:tgz:1.0.0")}.to raise_error(NexusCli::ArtifactNotFoundException)
  end

  it "gives you errors when you attempt to update an artifact's custom info and don't give valid parameters" do
    expect {remote.update_artifact_custom_info("com.something:something:tgz:1.0.0", "_somebadkey:_somebadvalue")}.to raise_error(NexusCli::N3ParameterMalformedException)
  end

  it "gives you errors when you attempt to update an artifact's custom info and don't give valid parameters" do
    expect {remote.update_artifact_custom_info("com.something:something:tgz:1.0.0", "_somebadkey")}.to raise_error(NexusCli::N3ParameterMalformedException)
  end

  it "gives you errors when you attempt to clear an artifact's custom info and it cannot be found" do
    expect_any_instance_of(HTTPClient).to receive(:get).and_raise(NexusCli::ArtifactNotFoundException)
    expect {remote.clear_artifact_custom_info("com.something:something:tgz:1.0.0")}.to raise_error(NexusCli::ArtifactNotFoundException)
  end

  it "gives you errors when you attempt to search for artifacts using custom info and don't give valid key" do
    expect {remote.search_artifacts_custom("somekey_:equal:somevalue")}.to raise_error(NexusCli::SearchParameterMalformedException)
  end

  it "gives you errors when you attempt to search for artifacts using custom info and don't give valid value" do
    expect {remote.search_artifacts_custom("somekey:equal:somevalue \"\'\\/")}.to raise_error(NexusCli::SearchParameterMalformedException)
  end

  it "gives you errors when you attempt to search for artifacts using custom info and don't give valid search type" do
    expect {remote.search_artifacts_custom("somekey:equals:somevalue")}.to raise_error(NexusCli::SearchParameterMalformedException)
  end

  it "gives you errors when you attempt to search for artifacts using custom info and don't give valid parameters" do
    expect {remote.search_artifacts_custom("somekey")}.to raise_error(NexusCli::SearchParameterMalformedException)
  end

  describe "tests for custom metadata private helper methods" do
    it "gives you errors when you attempt to parse custom metadata with bad update keys" do
      expect {remote.send(:parse_custom_metadata_update_params, "goodkey:goodvalue", "badkey_:goodvalue")}.to raise_error(NexusCli::N3ParameterMalformedException)
    end

    it "gives you errors when you attempt to parse custom metadata with missing update keys" do
      expect {remote.send(:parse_custom_metadata_update_params, ":goodvalue")}.to raise_error(NexusCli::N3ParameterMalformedException)
    end

    it "gives you errors when you attempt to parse custom metadata with typo" do
      expect {remote.send(:parse_custom_metadata_update_params, "goodkeygoodvalue")}.to raise_error(NexusCli::N3ParameterMalformedException)
    end

    it "gives you errors when you attempt to parse custom metadata with bad update values" do
      expect {remote.send(:parse_custom_metadata_update_params, "goodkey:goodvalue", "goodkey:badvalue\"'\\")}.to raise_error(NexusCli::N3ParameterMalformedException)
    end

    it "gives you errors when you attempt to parse custom metadata with missing search type and value" do
      expect {remote.send(:parse_custom_metadata_search_params, "goodkey")}.to raise_error(NexusCli::SearchParameterMalformedException)
    end

    it "gives you errors when you attempt to parse custom metadata with bad search type" do
      expect {remote.send(:parse_custom_metadata_search_params, "goodkey:eq:goodvalue")}.to raise_error(NexusCli::SearchParameterMalformedException)
    end

    it "gives you errors when you attempt to parse custom metadata with bad search value" do
      expect {remote.send(:parse_custom_metadata_search_params, "goodkey:equals:badvalue\"'\\")}.to raise_error(NexusCli::SearchParameterMalformedException)
    end
  end

  describe "tests for custom metadata private helper methods" do
    it "gives you errors when you attempt to parse custom metadata with bad update keys" do
      expect {remote.send(:parse_custom_metadata_update_params, "goodkey:goodvalue", "badkey_:goodvalue")}.to raise_error(NexusCli::N3ParameterMalformedException)
    end

    it "gives you errors when you attempt to parse custom metadata with missing update keys" do
      expect {remote.send(:parse_custom_metadata_update_params, ":goodvalue")}.to raise_error(NexusCli::N3ParameterMalformedException)
    end

    it "gives you errors when you attempt to parse custom metadata with typo" do
      expect {remote.send(:parse_custom_metadata_update_params, "goodkeygoodvalue")}.to raise_error(NexusCli::N3ParameterMalformedException)
    end

    it "gives you errors when you attempt to parse custom metadata with bad update values" do
      expect {remote.send(:parse_custom_metadata_update_params, "goodkey:goodvalue", "goodkey:badvalue\"'\\")}.to raise_error(NexusCli::N3ParameterMalformedException)
    end

    it "gives you errors when you attempt to parse custom metadata with missing search type and value" do
      expect {remote.send(:parse_custom_metadata_search_params, "goodkey")}.to raise_error(NexusCli::SearchParameterMalformedException)
    end

    it "gives you errors when you attempt to parse custom metadata with bad search type" do
      expect {remote.send(:parse_custom_metadata_search_params, "goodkey:eq:goodvalue")}.to raise_error(NexusCli::SearchParameterMalformedException)
    end

    it "gives you errors when you attempt to parse custom metadata with bad search value" do
      expect {remote.send(:parse_custom_metadata_search_params, "goodkey:equals:badvalue\"'\\")}.to raise_error(NexusCli::SearchParameterMalformedException)
    end
  end
end
