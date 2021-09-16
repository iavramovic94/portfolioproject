-- 1a Sum of total cases, total deaths, and death percentage in EU Countries

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as float))/SUM(cast(new_cases as float)) * 100 as DeathPercentage
From Covid_Deaths
where location in ('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden')
order by 1,2 

-- 1b Sum of total cases, deaths, and death percentage of non-EU countries 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as float))/SUM(cast(new_cases as float)) * 100 as DeathPercentage
From Covid_Deaths
where location in ('Albania', 'Andorra', 'Belarus', 'Bosnia and Herzegovina', 'Iceland', 'Kosovo', 'Liechtenstein', 'Moldova', 'Monaco', 'Montenegro', 'North Macedonia', 'Norway', 'Russia', 'San Marino', 'Serbia', 'Switzerland', 'Turkey', 'Ukraine', 'United Kingdom', 'Vatican')
order by 1,2 

-- 2a Total Death count of EU countries

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From Covid_Deaths
where location in ('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden')
Group by location
order by TotalDeathCount desc 

-- 2b Total Death Count of non-EU Countries 

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From Covid_Deaths
where location in ('Albania', 'Andorra', 'Belarus', 'Bosnia and Herzegovina', 'Iceland', 'Kosovo', 'Liechtenstein', 'Moldova', 'Monaco', 'Montenegro', 'North Macedonia', 'Norway', 'Russia', 'San Marino', 'Serbia', 'Switzerland', 'Turkey', 'Ukraine', 'United Kingdom', 'Vatican')
Group By Location 
order by TotalDeathCount desc 

-- 3a Percent Population Infected of EU Countries 

Select Location, Population, Max(total_cases) as HighestInfectionCount, Max((cast(total_cases as float)/population))*100 as PercentPopulationInfected
From Covid_Deaths
Where location in ('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden')
group by Location, population
Order by PercentPopulationInfected desc 

-- 3b Percent Population Infected of non-EU Countries 

Select Location, Population, Max(total_cases) as HighestInfectionCount, Max((cast(total_cases as float)/population))*100 as PercentPopulationInfected
From Covid_Deaths
Where location in ('Albania', 'Andorra', 'Belarus', 'Bosnia and Herzegovina', 'Iceland', 'Kosovo', 'Liechtenstein', 'Moldova', 'Monaco', 'Montenegro', 'North Macedonia', 'Norway', 'Russia', 'San Marino', 'Serbia', 'Switzerland', 'Turkey', 'Ukraine', 'United Kingdom', 'Vatican')
Group by Location, population
Order by PercentPopulationInfected desc 

-- 4a Percent Population Infected for forecasting (EU) 

Select Location, Population, date, MAX(total_cases) as HighestInfectionCount, MAX((cast(total_cases as float)/population))*100 as PercentPopulationInfected
from Covid_Deaths
Where Location in ('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden')
Group by location, population, date
order by PercentPopulationInfected desc 

-- 4b Percent Population Infected for forecasting (non-EU)

Select location, population, date, max(total_cases) as HighestInfectionCount, Max((cast(total_cases as float)/population))*100 as PercentPopulationInfected
From Covid_Deaths
Where location in ('Albania', 'Andorra', 'Belarus', 'Bosnia and Herzegovina', 'Iceland', 'Kosovo', 'Liechtenstein', 'Moldova', 'Monaco', 'Montenegro', 'North Macedonia', 'Norway', 'Russia', 'San Marino', 'Serbia', 'Switzerland', 'Turkey', 'Ukraine', 'United Kingdom', 'Vatican')
group by location, population, date
order by PercentPopulationInfected desc 