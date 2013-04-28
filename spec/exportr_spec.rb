require 'spec_helper'
require 'exportr'

describe Exportr do

  it 'finds configuration file' do
    File.exists?(Exportr.config_file).should == true
  end

  it 'reads configuration file' do
    Exportr.read['FOO'].should == 'bar'
  end

  it 'wrote configuration file to ENV' do
    ENV['FOO'].should == 'bar'
  end

end

