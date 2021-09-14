-- 1 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as float))/SUM(cast(new_cases as float)) * 100 as DeathPercentage
From Covid_Deaths
where continent is not NULL
order by 1,2 

-- 2 

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From Covid_Deaths
where continent is NULL
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc 

-- 3 

Select Location, Population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From Covid_Deaths
Group by Location, population
order by PercentPopulationInfected desc

-- 4 

Select Location, Population, date, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
from Covid_Deaths
Group by location, population, date
order by PercentPopulationInfected desc 