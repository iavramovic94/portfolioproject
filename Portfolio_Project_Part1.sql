Select *
From Covid_Deaths
where continent is not null
order by 3,4

-- Looking at Total Cases vs Total Deaths, shows likelihood of dying if you contract covid in your country
Select Location, date, total_cases, total_deaths,  cast(total_deaths as float) / total_cases as DeathPercentage
from Covid_Deaths
where location like '%states%'
order by 1,2

-- Looking at total cases vs population, shows percentage of population that got covid
Select Location, date, population, total_cases,  total_cases / cast(population as float) * 100  as PopulationPercentage
from Covid_Deaths
where location like '%states%'
and continent is not null 
order by 1,2

-- What countries have the highest infection rates compared to population
Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/ cast(population as float) ))* 100 as PercentPopulationInfected
From Covid_Deaths
Group By Location, population
order by PercentPopulationInfected desc

-- LETS BREAK THINGS DOWN BY CONTINENT 
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from Covid_Deaths
where continent is not null
Group by continent
Order by TotalDeathCount desc

-- Showing countries with Highest Death Count per population
Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
from Covid_Deaths
where continent is not null
Group by location
Order by TotalDeathCount desc

-- Global Numbers showing total death percentage globally sorted by date 
Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as float))/SUM(cast(new_cases as float)) * 100 as DeathPercentageGlobal
from Covid_Deaths
where continent is not null
Group by date
order by 1,2


SELECT *
From Covid_Deaths dea 
Join Covid_Vaccinations vac
	on dea.location = vac.location 
	and dea.date = vac.date 
	

-- Looking at Total Population vs Vaccinations - how many people in the world are vaccinated? 

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RolingPeopleVaccinated
From Covid_Deaths dea
join Covid_Vaccinations vac 
	on dea.location = vac.location
	and dea.date = vac.date 
where dea.continent is not null
order by 2,3


-- Using Rolling People Vaccinated divide by population to see how many people in the country are vaccinated -- USING CTE 

With PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From Covid_Deaths dea
join Covid_Vaccinations vac 
	on dea.location = vac.location
	and dea.date = vac.date 
where dea.continent is not null
)

Select *, (cast(RollingPeopleVaccinated as float)/Population)*100
From PopvsVac


-- TEMP TABLE 
Drop table if exists PercentPopulationVaccinated
Create TABLE PercentPopulationVaccinated

(
Continent nvarchar(255),
Location  nvarchar(255),
Date datetime, 
Population numeric,
New_Vaccinations numeric, 
RollingPeopleVaccinated numeric
)

Insert into PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From Covid_Deaths dea
join Covid_Vaccinations vac 
	on dea.location = vac.location
	and dea.date = vac.date 
where dea.continent is not null
-- order by 2,3

Select *, (cast(RollingPeopleVaccinated as float)/Population)*100
From PercentPopulationVaccinated


-- Creating View to sstore data for later visualizations 

Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From Covid_Deaths dea
join Covid_Vaccinations vac 
	on dea.location = vac.location
	and dea.date = vac.date 
where dea.continent is not null
--order by 2,3

Select * 
From PercentPopulationVaccinated