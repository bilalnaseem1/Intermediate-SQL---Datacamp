-- Select the team's long name and API id from the teams_germany table.
-- Filter the query for FC Schalke 04 and FC Bayern Munich using IN, giving you the team_api_IDs needed for the next step.

select team_long_name, team_api_id from teams_germany
where team_long_name in ('FC Schalke 04', 'FC Bayern Munich')

-- Create a CASE statement that identifies whether a match in Germany included FC Bayern Munich, FC Schalke 04, or neither as the home team.
-- Group the query by the CASE statement alias, home_team.

select
case when hometeam_id = 10189 then 'FC Schalke 04'
when hometeam_id = 9823 then 'FC Bayern Munich'
    else 'Other'
    END as home_team,
    count(id) as total_matches
    from matches_germany
    group by home_team
    
-- Select the date of the match and create a CASE statement to identify matches as home wins, home losses, or ties.

select date, 
case when home_goal > away_goal then 'Home win!'
	when home_goal < away_goal THEN 'Home loss :('
ELSE 'Tie' 
end
as outcome
from matches_spain

-- Left join the teams_spain table team_api_id column to the matches_spain table awayteam_id. This allows us to retrieve the away team's identity.
-- Select team_long_name from teams_spain as opponent and complete the CASE statement from Step 1.\

select m.date, 
		t.team_long_name as opponent, case when m.home_goal > m.away_goal then 'Home win!'
        when m.home_goal < m.away_goal then 'Home loss :('
        else 'Tie' 
		end 
		as outcome
from matches_spain as m
left join teams_spain as t
on m.awayteam_id = t.team_api_id

-- Complete the same CASE statement as the previous steps.
-- Filter for matches where the home team is FC Barcelona (id = 8634).

select m.date, 
		t.team_long_name as opponent, case when m.home_goal > m.away_goal then 'Barcelona win!'
        when m.home_goal < m.away_goal then 'Barcelona loss :(' 
        else 'Tie' 
		end 
		as outcome
from matches_spain as m
left join teams_spain as t
on m.awayteam_id = t.team_api_id
where m.hometeam_id = 8634


-- Complete the CASE statement to identify Barcelona's away team games (id = 8634) as wins, losses, or ties.
-- Left join the teams_spain table team_api_id column on the matches_spain table hometeam_id column. This retrieves the identity of the home team opponent.
-- Filter the query to only include matches where Barcelona was the away team.

select m.date, t.team_long_name as opponent,
case 
when m.home_goal < m.away_goal then 'Barcelona win!'
when m.home_goal > m.away_goal then 'Barcelona loss :('
else 'Tie'
end
as outcome
from matches_spain as m
left join teams_spain as t
on hometeam_id = team_api_id
where m.awayteam_id = 8634
