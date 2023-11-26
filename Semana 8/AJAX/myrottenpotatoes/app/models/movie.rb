class Movie < ActiveRecord::Base
    begin
        class Movie < ActiveRecord::Base
            has_many :reviews
            before_save :capitalize_title
            def capitalize_title
                self.title = self.title.split(/\s+/).map(&:downcase).
                map(&:capitalize).join(' ')
            end
        end
    end
end
