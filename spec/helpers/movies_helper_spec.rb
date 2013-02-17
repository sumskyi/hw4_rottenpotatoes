require 'spec_helper'

class MyClass
  extend MoviesHelper
end

describe MoviesHelper do
  it '.oddness' do
    MyClass.oddness(1).should be_true
  end

end
