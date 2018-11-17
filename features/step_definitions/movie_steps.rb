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

And(/^I check all ratings$/) do
  ratings = Movie.all_ratings

  ratings.each do |rating|
    check "ratings[#{rating}]"
  end

end

Then(/^I should see all of the movies$/) do
  assert_equal  Movie.all.count, page.all('table#movies tbody tr').count
end

Then(/^I should see "([^"]*)" before "([^"]*)"$/) do |name_1, name_2|
  regexp = /.*#{name_1}.*#{name_2}/

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Given(/^The following movies has the following directors:$/) do |table|
  table.rows.each do |row|
    movie = Movie.find_by_title(row[0])
    movie.director = row[1]
    movie.save
  end
end