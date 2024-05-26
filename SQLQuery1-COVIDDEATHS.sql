


select * from portfolioproject..CovidDeaths
order by 1,2
select * from portfolioproject..covidvaccination
order by 1,2

-TO SELECT DATA WE ARE GOING TO BE USING

select location,date,total_cases,new_cases,total_deaths,population from portfolioproject..CovidDeaths
order by 1,2


-TO GET DEATH PERCENTAGE (TOTAL CASES VS TOTAL DEATHS)

select date,location,total_cases,total_deaths, (total_deaths/total_cases)*100 as totaldeathpercentage from portfolioproject..CovidDeaths
where location like '%states%'
order by 1,2


-TO GET POPULATION PERCENTAGE (TOTAL CASES VS TOTAL POPULATION)

select location,date,population, total_cases, (total_cases/population)*100 as populationpercentage from portfolioproject..CovidDeaths
where location like '%states%'
order by 1,2

-LOOKING AT COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION

select location, population, max(total_cases) as highestinfected, max((total_cases/population))*100 as highestinfectedpercentage from portfolioproject..CovidDeaths
group by location,population
order by highestinfectedpercentage desc


-LOOKING AT COUNTRIES WITH HIGHEST DEATH RATE COMPARED TO POPULATION

select location, population, max(total_deaths) as highestdeaths, max((total_deaths/population))*100 as highestdeathpercentage from portfolioproject..CovidDeaths
WHERE continent is not null
group by location,population
order by highestdeathpercentage desc

-TO SEE CONTINENETS WITH HIGHEST DEATHS

select continent, max(cast(total_deaths as int)) as highestdeathrate from portfolioproject..CovidDeaths
where continent is not null
group by continent
order by highestdeathrate desc

-TO GET GLOBAL NUMBERS ACROSS THE WORLD

select date, sum(new_cases) as total_cases,sum(cast(new_deaths as int))as total_deaths, sum(cast(new_deaths as int))/sum(new_cases) *100 as totalnewdeaths from portfolioproject..CovidDeaths
where continent is not null
group by date
order by 1,2

-TO JOIN COVID DEATHS & COVID VACCINATION 

select * from portfolioproject..CovidDeaths dea join portfolioproject..covidvaccination vac
on dea.location=vac.location
and dea.date=vac.date

-LOOKING AT TOTAL POPULATION VS VACCINATION

select dea.continent, dea.population, dea.date, dea.location, vac.new_vaccination 
from portfolioproject..CovidDeaths dea join portfolioproject..covidvaccination vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 1,2,3