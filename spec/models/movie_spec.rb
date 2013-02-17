require 'spec_helper'

describe Movie do
  describe 'searching similar directors' do
    let(:director) { 'Lucash' }

    it 'should call Movie with director' do
      Movie.should_receive(:where).with(:director => director)
      Movie.similar_directors(director)
    end
  end
end
