def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie
    .select(:title, :id)
    .joins(:actors)
    .where('actors.name IN (?)', those_actors)
    .group(:id)
    .having('Count(actors.id) >= ?', those_actors.size)

end



def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .select("AVG(score), (yr / 10) * 10 AS decade")
    .group("decade")
    .order("avg(score) DESC")
    .first
    .decade
end


def costars(name)
  # List the names of the actors that the named actor has ever appeared with.
  # Hint: use a subquery

  subquery = Movie.select(:id).joins(:actors).where('actors.name = ?', name)

  Actor
    .joins(:movies)
    .where('actors.name != ?', name)
    .where('movies.id IN (?)', subquery)
    .distinct
    .pluck('actors.name')
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .select(:name)
    .joins('LEFT OUTER JOIN castings ON castings.actor_id = actors.id')
    .where('castings.id IS NULL')
    .count
end



def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the letters in whazzername,
  # ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but not like "stallone sylvester" or "zylvester ztallone"
  rough_string = "%#{whazzername.chars.join('%')}%"

  Movie
    .select('movies.*')
    .joins(:actors)
    .where('UPPER(actors.name) LIKE UPPER(?)', rough_string)

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of their career.

  Actor
    .select('actors.id, actors.name, MAX(movies.yr) - MIN(movies.yr) AS career')
    .joins(:movies)
    .group('actors.id')
    .order('MAX(movies.yr) - MIN(movies.yr) DESC, actors.name')
    .limit(3)
end
