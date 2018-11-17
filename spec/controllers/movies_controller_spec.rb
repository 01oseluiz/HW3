require 'rails_helper'

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
          @movie_params[:director] = "Stan Lee"

          post :update, params: {id:movie.id, movie: @movie_params}

          expect(Movie.find(movie).director).to eq("Stan Lee")
          expect(response).to redirect_to(movie_path(movie))
        end
      end

      context 'when director exist' do
        it 'should show all movies with the same director' do
          pending
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