require 'spec_helper'

describe MoviesHelper do
  it '.oddness' do
    helper.oddness(1).should be_true
  end
end
