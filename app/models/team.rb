require 'open-uri'

class Team < ActiveRecord::Base

	scope :winning_order, -> { order(won: :desc) }
	scope :western, -> { where(conference: 'Western') }
	scope :eastern, -> { where(conference: 'Eastern') }

	def self.from_nba_standings
		 doc = Nokogiri::HTML.parse(open("http://www.nba.com/standings/team_record_comparison/conferenceNew_Std_Cnf.html?ls=iref:nba:gnav"))
		 index = 0

		 doc.css('table.mainStandings tr').each do |team_info|
		 	next if team_info.attributes == {} or team_info.attributes['class'].text == 'title'

		 	attributes = {}

		 	attributes[:team] = team_info.at_css('td.team').children.first.text
		 	attributes[:won], attributes[:lost] = team_info.css('td')[1..2].map(&:text).map(&:to_i)
		 	attributes[:played] = attributes[:won] + attributes[:lost]
		 	attributes[:streak] = team_info.css('td').children.last.text
		 	attributes[:conference] = index > 14 ? 'Western' : 'Eastern'

		 	if team = Team.find_by(team: attributes[:team]).presence
		 		team.update_attributes(attributes)
		 	else
		 		Team.create!(attributes)
		 	end

		 	index = index + 1
		 end


	end
end
