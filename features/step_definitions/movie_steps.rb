Given "the following movies exist:" do |table|

  table.rows.each do |row|

    @movie = Movie.new

    row.each_with_index do |value, index|
      @movie[table.headers[index]] = value
    end

    @movie.save
  end

end

Given /^I check the following ratings: (.*)$/ do |ratings_string|

  ratings = ratings_string.split(/,\s*/)

  ratings.each do |rating|
    check "ratings[#{rating}]"
  end

end

Given /^I uncheck the following ratings: (.*)$/ do |ratings_string|
  ratings = ratings_string.split(/,\s*/)

  ratings.each do |rating|
    uncheck "ratings[#{rating}]"
  end
end

Then(/^I should see all of the movies$/) do
  assert_equal  Movie.all.count, page.all('table#movies tbody tr').count
end
