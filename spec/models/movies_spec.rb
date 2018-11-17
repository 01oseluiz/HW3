require 'rails_helper'


RSpec.describe Movie, type: :model do

  describe 'Add director to movie and find with the same director' do

    context 'when movie already exist' do
      before do
        Movie.create(title: 'The Terminator',  rating: 'PG-13', release_date: '26-Oct-1984')
        Movie.create(title: 'When Harry Met Sally',  rating: 'R', release_date: '21-Jul-1989')
      end

      it 'should add a director to an movie' do

        expect(Movie.count).not_to eq(0)

        Movie.all.each do |movie|
          movie.director = "Director X"
          movie.save
        end

        Movie.all.each do |movie|
          expect(movie.director).to eq("Director X")
        end
      end

      context 'when director exist' do
        before do
          Movie.all.each do |movie|
            movie.director = "Director X"
            movie.save
          end
          Movie.create(title: 'When Harry Met Sally',  rating: 'R', release_date: '21-Jul-1989', director: "Another Director X")
        end

        it 'should find movies with the same director' do
          expect(Movie.count).not_to eq(0)

          Movie.all.each do |movie|
            expect(movie.movies_with_same_director.count).to be >= 1
            expect(movie.movies_with_same_director.include? movie).to be_truthy
          end
        end
      end

      context 'when director not exist' do
        it 'should not find movies with the same director' do
          expect(Movie.count).not_to eq(0)

          Movie.all.each do |movie|
            expect(movie.movies_with_same_director).to be_nil
          end
        end
      end
    end

  end

end