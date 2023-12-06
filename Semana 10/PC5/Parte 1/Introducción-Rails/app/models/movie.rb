class Movie < ActiveRecord::Base
    def self.with_ratings(ratings_list)
      if ratings_list.nil? || ratings_list.empty?
        all
      else
        where(rating: ratings_list)
      end
    end
  
    def self.all_ratings
      ['G', 'PG', 'PG-13', 'R']
    end
  end
  