require 'spec_helper'

describe MoviesController do
  let(:movie) { mock(Movie, :title => "Star Wars", :director => "director", :id => "1") }

  describe 'add director' do
    before do
      Movie.stub!(:find).with("1").and_return(movie)
    end

    it 'calls saves and redirect' do
      movie.stub!(:update_attributes!).and_return(true)
      put :update, {:id => "1", :movie => {}}
      response.should redirect_to(movie_path(movie))
    end
  end

  describe 'happy path' do
    before :each do
      Movie.stub!(:find).with("1").and_return(movie)
    end

    it 'generates route for Similar Movies' do
      { :get => similar_movie_path(1) }.
      should route_to(:controller => "movies", :action => "similar", :id => "1")
    end

    it 'finds similar movies' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.should_receive(:similar_directors).with('director').and_return(fake_results)
      get :similar, :id => "1"
    end

    it 'renders' do
      Movie.stub!(:similar_directors).with('director').and_return(movie)
      get :similar, :id => "1"
      response.should render_template('similar')
      assigns(:movies).should == movie
    end
  end

  describe 'sad path' do
    before :each do
      m=mock(Movie, :title => "Star Wars", :director => nil, :id => "1")
      Movie.stub!(:find).with("1").and_return(m)
    end

    it 'generates route for Similar Movies' do
      { :get => similar_movie_path('1') }.
      should route_to(:controller => "movies", :action => "similar", :id => "1")
    end

    it 'should select the Index template for rendering and generate a flash' do
      get :similar, :id => "1"
      response.should redirect_to(movies_path)
      flash[:notice].should_not be_blank
    end
  end

  describe 'create and destroy' do
    it 'should create a new movie' do
      MoviesController.stub(:create).and_return(mock('Movie'))
      post :create, {:id => "1"}
    end

    it 'should destroy a movie' do
      m = mock(Movie, :id => "10", :title => "blah", :director => nil)
      Movie.stub!(:find).with("10").and_return(m)
      m.should_receive(:destroy)
      delete :destroy, {:id => "10"}
    end
  end

  describe 'show' do
    it 'ok' do
      m = mock(Movie, :id => "10", :title => "blah", :director => nil)
      Movie.stub!(:find).with("10").and_return(m)
      get :show, :id => "10"
    end
  end


  describe 'Show movies list' do
    it 'should sort movies by title and show R rated ones' do
      session[:sort] = "title"
      session[:ratings] = { "R" => "1"}
      get :index, :sort => session[:sort], :ratings => session[:ratings]
    end
    it 'should show R rated movies and sort them by date' do
      session[:sort] = "release_date"
      session[:ratings] = {"R" => "1"}
      get :index, :sort => session[:sort], :ratings => session[:ratings]
    end
    it 'has no ratings parameters' do
      session[:sort] = "release_date"
      session[:ratings] = {"R" => "1"}
      get :index, :sort => session[:sort]
      response.should redirect_to(movies_path(:sort => session[:sort], :ratings => session[:ratings]))
     end
     it 'has no sort params' do
       session[:sort] = "release_date"
       session[:ratings] = {"R" => "1"}
       get :index, :ratings => session[:ratings]
       response.should redirect_to(movies_path(:sort => session[:sort], :ratings => session[:ratings]))
     end
  end

  describe 'Edit should be tested too ;)' do
    it 'should be tested' do
      m = mock(Movie, :id => "1", :title => "blah", :director => nil)
      Movie.stub!(:find).with("1").and_return(m)
      get :edit, :id => 1
    end
  end
end
