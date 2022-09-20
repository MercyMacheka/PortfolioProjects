select *
from ..coviddeaths
order by 3,4


--select *
--from ..covidvaccinations
--order by 3,4

-- select data that we are going to be using

select date,location,total_cases,new_cases,total_deaths,population
from ..coviddeaths
order by 1,2


-- looking at total_cases vs total_deaths
-- shows likelihood of dying if you contract covid in your country

select date,location,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from ..coviddeaths
where location like '%states%'
order by 1,2

--looking at total_cases vs population
-- shows what percentage of population got covid

select location,date,population,total_cases,(total_cases/population)*100 as PercentPopulationInfected
from ..coviddeaths
--where location like '%states%'
order by 1,2

-- looking at countries with highest infection rate compared to population

select location,population,max (total_cases)as highestInfectionCount,max((total_cases/population))*100 as PercentPopulationInfected
from ..coviddeaths
--where location like '%states%'
group by population,location
order by PercentPopulationInfected desc


--showing countries with highest death count per population

select location,MAX(cast(total_deaths as int)) as TotalDeathCount
from ..coviddeaths
--where location like '%states%'
where continent is not null
group by location
order by TotalDeathCount desc

--lets break things down by continent

select location,MAX(cast(total_deaths as int)) as TotalDeathCount
from ..coviddeaths
--where location like '%states%'
where continent is not null
group by location
order by TotalDeathCount desc


--showing the continents with the highest death count per population

select location,MAX(cast(total_deaths as int)) as TotalDeathCount
from ..coviddeaths
--where location like '%states%'
where continent is not null
group by location
order by TotalDeathCount desc

-- global numbers

select date,sum(new_cases)AS TotalCases, SUM(cast (new_deaths as int)) as TotalDeaths, sum(cast(new_deaths AS int ))/SUM(new_cases)*100 as DeathPercentage
from ..coviddeaths
--where location like '%states%'
where continent is not null
group by date
order by 1,2

select *
from ..coviddeaths dea
join ..covidvaccinations vac
 on dea.location =vac.location
 and dea.date= vac.date


 --looking at total population vs vaccination

 select dea.continent , dea.location, dea.date,dea.population,vac.new_vaccinations,SUM(convert (bigint,vac.new_vaccinations)) over(partition by dea.location  ) as RollingPeopleVaccinated
 --,(RollingPeopleVaccinated)/ population)* 100
  from ..coviddeaths dea 
  join..covidvaccinations vac
 on dea.location =vac.location
 and dea.date= vac.date
 where dea.continent is not null


 --use CTE

 with PopvsVac



 --TEMP TABLE


  