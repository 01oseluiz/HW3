require 'rails_helper'
require 'spec_helper'

RSpec.describe MoviesController, type: :controller do

  describe 'Add director and show all movies with the same director' do

    context 'when movie already exist' do
      before do
        Movie.create(title: 'The Terminator',  rating: 'PG-13', release_date: '26-Oct-1984')
        Movie.create(title: 'When Harry Met Sally',  rating: 'R', release_date: '21-Jul-1989')
      end

      it 'should add director to an existent movie' do
        expect(Movie.count).to_not eq(0)

        Movie.all.each do |movie|
          @movie_params = movie.attributes
          @movie_params[:director] = "Director X"

          post :update, params: {id:movie.id, movie: @movie_params}

          expect(Movie.find(movie).director).to eq("Director X")
          expect(response).to redirect_to(movie_path(movie))
        end
      end

      context 'when director exist' do
        before do
          Movie.all.each do |movie|
            movie.director = "Director X"
          end
          Movie.create(title: 'When Harry Met Sally',  rating: 'R', release_date: '21-Jul-1989', director: "Another Director X")
        end

        it 'should show all movies with the same director' do
          expect(Movie.count).not_to eq(0)

          Movie.all.each do |movie|
            get :movies_by_director, params: {id: movie.id}
            expect(response).to have_http_status(200)
          end

        end
      end

      context 'when director not exist' do
        it 'should not show all movies with the same director' do
          pending
        end
      end
    end

  end

end