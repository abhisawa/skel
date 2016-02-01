require_relative '../../spec/spec_helper'
require 'skel/command/example'

describe 'Skel::Command::Example' do
  it '#call' do
    expect(Skel::Command::Example.new('example', \
                                      %w(arg1 arg2), \
                                      opt1: true, opt2: 'option two', \
                                      verbose: true).call).to eq(true)
  end
end
