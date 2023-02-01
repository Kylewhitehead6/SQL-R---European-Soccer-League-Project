#Best soccer league

#Background: How competitive are the top 5 European Leagues? What does competitive actually mean? 
#competitive is a vague term - we will look at winners, top 4 contenders, points earned from the bottom teams from the top teams (maybe bottom 10 vs big 6 over the entire 10 seasons)

#Goal: to explore the top 5 european leagues and determine the overall competitiveness of each league using R & SQL 

#Data from 
#http://www.football-data.co.uk

# R is mainly used in lines: 14-350 for inputting the data into R and extensive cleaning 
# Then after that there is a mixture of SQL and R for the analysis

# When looking through the cleaning and analysis,
# Note that much of the code is duplicates for each of the 5 leagues
# So for sake of reading and understanding, find 1 league and follow its code through


#----------------------------------------------------------------------------------------------------

#Packages
library(lubridate)
library(tidyverse)
library(dplyr)
library(sqldf)


#----------------------------------------------------------------------------------------------------


#Premier League

prem0910 = read.csv("input/Premier League/prem0910.csv")
prem1011 = read.csv("input/Premier League/prem1011.csv")
prem1112 = read.csv("input/Premier League/prem1112.csv")
prem1213 = read.csv("input/Premier League/prem1213.csv")
prem1314 = read.csv("input/Premier League/prem1314.csv")
prem1415 = read.csv("input/Premier League/prem1415.csv")
prem1516 = read.csv("input/Premier League/prem1516.csv")
prem1617 = read.csv("input/Premier League/prem1617.csv")
prem1718 = read.csv("input/Premier League/prem1718.csv")
prem1819 = read.csv("input/Premier League/prem1819.csv")

#View(prem0910) #YYYY/MM/DD
#View(prem1415) #DD/MM/yy
#View(prem1819) #DD/MM/YYYY

#CONDENSE DATAFRAMES TO SPECIFIC COLUMNS
prem0910 = prem0910[,c(1:23)]
prem1011 = prem1011[,c(1:23)]
prem1112 = prem1112[,c(1:23)]
prem1213 = prem1213[,c(1:23)]
prem1314 = prem1314[,c(1:23)]
prem1415 = prem1415[,c(1:23)]
prem1516 = prem1516[,c(1:23)]
prem1617 = prem1617[,c(1:23)]
prem1718 = prem1718[,c(1:23)]
prem1819 = prem1819[,c(1:23)]

#MERGE ALL SEASON DATA TOGETHER
premalldata = do.call("rbind", list(prem0910, prem1011, prem1112, prem1213, prem1314, prem1415,
                                    prem1516, prem1617, prem1718, prem1819))
#View(premalldata)

#FIX DATE

premalldata$Date = parse_date_time(premalldata$Date,orders = c("dmy","ymd"))

#ADD SEASON
premalldata$season[1:380] = "09/10"
premalldata$season[381:760] = "10/11"
premalldata$season[761:1140] = "11/12"
premalldata$season[1141:1520] = "12/13"
premalldata$season[1521:1900] = "13/14"
premalldata$season[1901:2280] = "14/15"
premalldata$season[2281:2660] = "15/16"
premalldata$season[2661:3040] = "16/17"
premalldata$season[3041:3420] = "17/18"
premalldata$season[3421:3800] = "18/19"

#ADD POINTS
premalldata$HomeTeamPoints = ifelse(premalldata$FTHG > premalldata$FTAG, 3,
                                    ifelse(premalldata$FTHG == premalldata$FTAG,1,0))
premalldata$AwayTeamPoints = ifelse(premalldata$FTHG > premalldata$FTAG, 0,
                                    ifelse(premalldata$FTHG == premalldata$FTAG,1,3))

#GET RID OF UNNECCESSARY COLUMNS
premalldata = premalldata[,c(1:6,24:26)]

#REORDER COLUMNS
premalldata = premalldata[,c(1,2,7,3,4,5,6,8,9)]

#-------------------------------------------------------------------------------------------------
#Bundesliga

bund0910 = read.csv("input/Bundesliga/Bundesliga0910.csv")
bund1011 = read.csv("input/Bundesliga/Bundesliga1011.csv")
bund1112 = read.csv("input/Bundesliga/Bundesliga1112.csv")
bund1213 = read.csv("input/Bundesliga/Bundesliga1213.csv")
bund1314 = read.csv("input/Bundesliga/Bundesliga1314.csv")
bund1415 = read.csv("input/Bundesliga/Bundesliga1415.csv")
bund1516 = read.csv("input/Bundesliga/Bundesliga1516.csv")
bund1617 = read.csv("input/Bundesliga/Bundesliga1617.csv")
bund1718 = read.csv("input/Bundesliga/Bundesliga1718.csv")
bund1819 = read.csv("input/Bundesliga/Bundesliga1819.csv")

#think its the same data format as prem
#View(bund0910)
#View(bund1314)
#View(bund1819)

#CONDENSE DATAFRAMES TO SPECIFIC COLUMNS
bund0910 = bund0910[,c(1:23)]
bund1011 = bund1011[,c(1:23)]
bund1112 = bund1112[,c(1:23)]
bund1213 = bund1213[,c(1:23)]
bund1314 = bund1314[,c(1:23)]
bund1415 = bund1415[,c(1:23)]
bund1516 = bund1516[,c(1:23)]
bund1617 = bund1617[,c(1:23)]
bund1718 = bund1718[,c(1:23)]
bund1819 = bund1819[,c(1:23)]

#MERGE ALL SEASON DATA TOGETHER
bundalldata = do.call("rbind", list(bund0910, bund1011, bund1112, bund1213, bund1314, bund1415,
                                    bund1516, bund1617, bund1718, bund1819))
#View(bundalldata)

#FIX DATE

bundalldata$Date = parse_date_time(bundalldata$Date,orders = c("dmy","ymd"))

#ADD SEASON
bundalldata$season[1:306] = "09/10"
bundalldata$season[307:612] = "10/11"
bundalldata$season[613:918] = "11/12"
bundalldata$season[919:1224] = "12/13"
bundalldata$season[1225:1530] = "13/14"
bundalldata$season[1531:1836] = "14/15"
bundalldata$season[1837:2142] = "15/16"
bundalldata$season[2143:2448] = "16/17"
bundalldata$season[2449:2754] = "17/18"
bundalldata$season[2755:3060] = "18/19"

bundalldata$B365H = NULL

#ADD POINTS
bundalldata$HomeTeamPoints = ifelse(bundalldata$FTHG > bundalldata$FTAG, 3,
                                    ifelse(bundalldata$FTHG == bundalldata$FTAG,1,0))
bundalldata$AwayTeamPoints = ifelse(bundalldata$FTHG > bundalldata$FTAG, 0,
                                    ifelse(bundalldata$FTHG == bundalldata$FTAG,1,3))

#GET RID OF UNNECCESSARY COLUMNS
bundalldata = bundalldata[,c(1:6,23:25)]

#REORDER COLUMNS
bundalldata = bundalldata[,c(1,2,7,3,4,5,6,8,9)]

#-----------------------------------------------------------------------------------------------------

#Serie A

italy0910 = read.csv("input/Serie A/SerieA0910.csv")
italy1011 = read.csv("input/Serie A/SerieA1011.csv")
italy1112 = read.csv("input/Serie A/SerieA1112.csv")
italy1213 = read.csv("input/Serie A/SerieA1213.csv")
italy1314 = read.csv("input/Serie A/SerieA1314.csv")
italy1415 = read.csv("input/Serie A/SerieA1415.csv")
italy1516 = read.csv("input/Serie A/SerieA1516.csv")
italy1617 = read.csv("input/Serie A/SerieA1617.csv")
italy1718 = read.csv("input/Serie A/SerieA1718.csv")
italy1819 = read.csv("input/Serie A/SerieA1819.csv")

#View(italy0910)
#View(italy1415)
#View(italy1819)
#again dates think are same as prem

#CONDENSE DATAFRAMES TO SPECIFIC COLUMNS
italy0910 = italy0910[,c(1:23)]
italy1011 = italy1011[,c(1:23)]
italy1112 = italy1112[,c(1:23)]
italy1213 = italy1213[,c(1:23)]
italy1314 = italy1314[,c(1:23)]
italy1415 = italy1415[,c(1:23)]
italy1516 = italy1516[,c(1:23)]
italy1617 = italy1617[,c(1:23)]
italy1718 = italy1718[,c(1:23)]
italy1819 = italy1819[,c(1:23)]

#MERGE ALL SEASON DATA TOGETHER
italyalldata = do.call("rbind", list(italy0910, italy1011, italy1112, italy1213, italy1314, italy1415,
                                     italy1516, italy1617, italy1718, italy1819))
#View(italyalldata)

italyalldata$B365H = NULL

#FIX DATE

italyalldata$Date = parse_date_time(italyalldata$Date,orders = c("dmy","ymd"))

#ADD SEASON
italyalldata$season[1:380] = "09/10"
italyalldata$season[381:760] = "10/11"
italyalldata$season[761:1140] = "11/12"
italyalldata$season[1141:1520] = "12/13"
italyalldata$season[1521:1900] = "13/14"
italyalldata$season[1901:2280] = "14/15"
italyalldata$season[2281:2660] = "15/16"
italyalldata$season[2661:3040] = "16/17"
italyalldata$season[3041:3420] = "17/18"
italyalldata$season[3421:3800] = "18/19"

#ADD POINTS
italyalldata$HomeTeamPoints = ifelse(italyalldata$FTHG > italyalldata$FTAG, 3,
                                     ifelse(italyalldata$FTHG == italyalldata$FTAG,1,0))
italyalldata$AwayTeamPoints = ifelse(italyalldata$FTHG > italyalldata$FTAG, 0,
                                     ifelse(italyalldata$FTHG == italyalldata$FTAG,1,3))

#GET RID OF UNNECCESSARY COLUMNS
italyalldata = italyalldata[,c(1:6,23:25)]

#REORDER COLUMNS
italyalldata = italyalldata[,c(1,2,7,3,4,5,6,8,9)]

#--------------------------------------------------------------------------------------------------

#La Liga

laliga0910 = read.csv("input/La Liga/laliga0910.csv")
laliga1011 = read.csv("input/La Liga/laliga1011.csv")
laliga1112 = read.csv("input/La Liga/laliga1112.csv")
laliga1213 = read.csv("input/La Liga/laliga1213.csv")
laliga1314 = read.csv("input/La Liga/laliga1314.csv")
laliga1415 = read.csv("input/La Liga/laliga1415.csv")
laliga1516 = read.csv("input/La Liga/laliga1516.csv")
laliga1617 = read.csv("input/La Liga/laliga1617.csv")
laliga1718 = read.csv("input/La Liga/laliga1718.csv")
laliga1819 = read.csv("input/La Liga/laliga1819.csv")

#View(laliga0910)
#View(laliga1415)
#View(laliga1819)
#again dates think are same as prem

#CONDENSE DATAFRAMES TO SPECIFIC COLUMNS
laliga0910 = laliga0910[,c(1:23)]
laliga1011 = laliga1011[,c(1:23)]
laliga1112 = laliga1112[,c(1:23)]
laliga1213 = laliga1213[,c(1:23)]
laliga1314 = laliga1314[,c(1:23)]
laliga1415 = laliga1415[,c(1:23)]
laliga1516 = laliga1516[,c(1:23)]
laliga1617 = laliga1617[,c(1:23)]
laliga1718 = laliga1718[,c(1:23)]
laliga1819 = laliga1819[,c(1:23)]

#MERGE ALL SEASON DATA TOGETHER
laligaalldata = do.call("rbind", list(laliga0910, laliga1011, laliga1112, laliga1213, laliga1314, laliga1415,
                                      laliga1516, laliga1617, laliga1718, laliga1819))
#View(laligaalldata)

laligaalldata$B365H = NULL

#FIX DATE

laligaalldata$Date = parse_date_time(laligaalldata$Date,orders = c("dmy","ymd"))

#ADD SEASON
laligaalldata$season[1:380] = "09/10"
laligaalldata$season[381:760] = "10/11"
laligaalldata$season[761:1140] = "11/12"
laligaalldata$season[1141:1520] = "12/13"
laligaalldata$season[1521:1900] = "13/14"
laligaalldata$season[1901:2280] = "14/15"
laligaalldata$season[2281:2660] = "15/16"
laligaalldata$season[2661:3040] = "16/17"
laligaalldata$season[3041:3420] = "17/18"
laligaalldata$season[3421:3800] = "18/19"

#ADD POINTS
laligaalldata$HomeTeamPoints = ifelse(laligaalldata$FTHG > laligaalldata$FTAG, 3,
                                      ifelse(laligaalldata$FTHG == laligaalldata$FTAG,1,0))
laligaalldata$AwayTeamPoints = ifelse(laligaalldata$FTHG > laligaalldata$FTAG, 0,
                                      ifelse(laligaalldata$FTHG == laligaalldata$FTAG,1,3))

#GET RID OF UNNECCESSARY COLUMNS
laligaalldata = laligaalldata[,c(1:6,23:25)]

#REORDER COLUMNS
laligaalldata = laligaalldata[,c(1,2,7,3,4,5,6,8,9)]

#-------------------------------------------------------------------------------------------------------

#Ligue 1

french0910 = read.csv("input/Ligue 1/French0910.csv")
french1011 = read.csv("input/Ligue 1/French1011.csv")
french1112 = read.csv("input/Ligue 1/French1112.csv")
french1213 = read.csv("input/Ligue 1/French1213.csv")
french1314 = read.csv("input/Ligue 1/French1314.csv")
french1415 = read.csv("input/Ligue 1/French1415.csv")
french1516 = read.csv("input/Ligue 1/French1516.csv")
french1617 = read.csv("input/Ligue 1/French1617.csv")
french1718 = read.csv("input/Ligue 1/French1718.csv")
french1819 = read.csv("input/Ligue 1/French1819.csv")

#View(french0910)
#View(french1415)
#View(french1819)
#again dates think are same as prem

#CONDENSE DATAFRAMES TO SPECIFIC COLUMNS
french0910 = french0910[,c(1:23)]
french1011 = french1011[,c(1:23)]
french1112 = french1112[,c(1:23)]
french1213 = french1213[,c(1:23)]
french1314 = french1314[,c(1:23)]
french1415 = french1415[,c(1:23)]
french1516 = french1516[,c(1:23)]
french1617 = french1617[,c(1:23)]
french1718 = french1718[,c(1:23)]
french1819 = french1819[,c(1:23)]

#MERGE ALL SEASON DATA TOGETHER
frenchalldata = do.call("rbind", list(french0910, french1011, french1112, french1213, french1314, french1415,
                                      french1516, french1617, french1718, french1819))
#View(frenchalldata)

frenchalldata$B365H = NULL

#FIX DATE

frenchalldata$Date = parse_date_time(frenchalldata$Date,orders = c("dmy","ymd"))

#ADD SEASON
frenchalldata$season[1:380] = "09/10"
frenchalldata$season[381:760] = "10/11"
frenchalldata$season[761:1140] = "11/12"
frenchalldata$season[1141:1520] = "12/13"
frenchalldata$season[1521:1900] = "13/14"
frenchalldata$season[1901:2280] = "14/15"
frenchalldata$season[2281:2660] = "15/16"
frenchalldata$season[2661:3040] = "16/17"
frenchalldata$season[3041:3420] = "17/18"
frenchalldata$season[3421:3800] = "18/19"

#ADD POINTS
frenchalldata$HomeTeamPoints = ifelse(frenchalldata$FTHG > frenchalldata$FTAG, 3,
                                      ifelse(frenchalldata$FTHG == frenchalldata$FTAG,1,0))
frenchalldata$AwayTeamPoints = ifelse(frenchalldata$FTHG > frenchalldata$FTAG, 0,
                                      ifelse(frenchalldata$FTHG == frenchalldata$FTAG,1,3))

#GET RID OF UNNECCESSARY COLUMNS
frenchalldata = frenchalldata[,c(1:6,23:25)]

#REORDER COLUMNS
frenchalldata = frenchalldata[,c(1,2,7,3,4,5,6,8,9)]

#---------------------------------------------------------------------------------------------------

#Analysis

#Reference
sqldf("select [Sepal.Width] from iris
      where
        [Sepal.Width]  >= 3.0")
#Test
sqldf("SELECT * FROM premalldata WHERE [HomeTeam] = 'Liverpool' AND [Season] = '18/19'")

#-------
#Let's start with the Prem

#Get League Table for all seasons
#Using SQL
sqldf("SELECT Team, sum(Points) as Points, season
          FROM 
          (SELECT HomeTeam as Team, sum(HomeTeamPoints) as Points, season FROM premalldata GROUP BY Team, season
          UNION
          SELECT AwayTeam as Team, sum(AwayTeamPoints) as Points, season FROM premalldata GROUP BY Team,season)
      GROUP BY Team, season
      ORDER BY season, Points desc")
#Using R

premalldata%>%
  select(Team = HomeTeam,Points = HomeTeamPoints, season) %>%
  bind_rows(premalldata%>%
              select(Team = AwayTeam,Points = AwayTeamPoints, season))%>%
  group_by(Team, season)%>%
  summarise(Points = sum(Points))%>%
  arrange(season, desc(Points))%>%
  print(n = 200)
#its nice to separate the seasons, but if we do it rMarkdown, ill see about adding that
#i dont want to write it out separately right now


#identify bottom 6 points vs top 6 per season

#make table for all 10 seasons and add position in table (Rank) for team during a season
premtable <- as.data.frame(sqldf("SELECT Team, sum(Points) as Points, season
          FROM 
          (SELECT HomeTeam as Team, sum(HomeTeamPoints) as Points, season FROM premalldata GROUP BY Team, season
          UNION
          SELECT AwayTeam as Team, sum(AwayTeamPoints) as Points, season FROM premalldata GROUP BY Team,season)
      GROUP BY Team, season
      ORDER BY season, Points desc"))

premtable$Rank <-rep(c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),times=10)


#Add the ranks to premalldata for home and awayteams

premalldata <- sqldf("SELECT Div, Date, p1.season, HomeTeam, AwayTeam, FTHG, FTAG, HomeTeamPoints, AwayTeamPoints, p2.Rank as HomeRank, p3.Rank as AwayRank
      FROM premalldata p1
      LEFT JOIN premtable p2 ON p1.HomeTeam = p2.Team AND p1.season = p2.season
      LEFT JOIN premtable p3 ON p1.AwayTeam = p3.Team AND p1.season = p3.season")


#YES!
sqldf("SELECT season, sum(CASE 
      WHEN HomeRank BETWEEN 1 and 6 and AwayRank BETWEEN 15 and 20 THEN AwayTeamPoints
      WHEN HomeRank BETWEEN 15 and 20 and AwayRank BETWEEN 1 and 6 THEN HomeTeamPoints END) AS Bottom6Points
      FROM premalldata
      GROUP BY season")


#Double Checking sum is correct for 10/11

#Good
sqldf("SELECT season,HomeTeam, AwayTeam, HomeTeamPoints,AwayTeamPoints
      FROM premalldata WHERE HomeTeam in 
      (SELECT Team from premtable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') 
      AND AwayTeam in
      (SELECT Team from premtable WHERE Rank BETWEEN 15 AND 20 and season = '10/11')
      and season = '10/11'
      or HomeTeam in 
      (SELECT Team from premtable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') 
      AND AwayTeam in
      (SELECT Team from premtable WHERE Rank BETWEEN 1 AND 6 and season = '10/11')
      AND season = '10/11'")

#Sum only 10/11 - THIS IS RIGHT (after manually checking 1 code block above) 
sqldf("SELECT season,sum(CASE
      WHEN HomeTeam in 
      (SELECT Team from premtable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') AND AwayTeam in
      (SELECT Team from premtable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') THEN AwayTeamPoints
      WHEN HomeTeam in 
      (SELECT Team from premtable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') AND AwayTeam in
      (SELECT Team from premtable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') THEN HomeTeamPoints END) as Bottom6Points
      FROM premalldata
      WHERE season = '10/11'")

#Identify leagues winners for last 10 seasons - this becomes much easier after creating the code for big 6 vs bottom 6 below
#SQL
sqldf("SELECT Team as Champion, season
      FROM premtable 
      WHERE Rank = 1")

#Identify how many times a team has placed top 4 in last 10 seasons 

sqldf("SELECT Team, Count(*) as Top4Finishes
      FROM premtable 
      WHERE Rank BETWEEN 1 AND 4
      GROUP BY Team
      ORDER by Top4Finishes DESC")


#------------------------------------------------------

#Bundesliga - we should be able to just code from above and switch tables to bundesliga

#Get League Table for all seasons
#Using SQL
sqldf("SELECT Team, sum(Points) as Points, season
          FROM 
          (SELECT HomeTeam as Team, sum(HomeTeamPoints) as Points, season FROM bundalldata GROUP BY Team, season
          UNION
          SELECT AwayTeam as Team, sum(AwayTeamPoints) as Points, season FROM bundalldata GROUP BY Team,season)
      GROUP BY Team, season
      ORDER BY season, Points desc")
#Using R
bundalldata%>%
  select(Team = HomeTeam,Points = HomeTeamPoints, season) %>%
  bind_rows(bundalldata%>%
              select(Team = AwayTeam,Points = AwayTeamPoints, season))%>%
  group_by(Team, season)%>%
  summarise(Points = sum(Points))%>%
  arrange(season, desc(Points))%>%
  print(n = 200)
#its nice to separate the seasons, but if we do it rMarkdown, ill see about adding that
#i dont want to write it out separately right now


#identify bottom 6 points vs top 6 per season

#make table for all 10 seasons and add position in table (Rank) for team during a season
bundtable <- as.data.frame(sqldf("SELECT Team, sum(Points) as Points, season
          FROM 
          (SELECT HomeTeam as Team, sum(HomeTeamPoints) as Points, season FROM bundalldata GROUP BY Team, season
          UNION
          SELECT AwayTeam as Team, sum(AwayTeamPoints) as Points, season FROM bundalldata GROUP BY Team,season)
      GROUP BY Team, season
      ORDER BY season, Points desc"))

#have to adjust rep as there are only 18 teams in the bundesliga
bundtable$Rank <-rep(c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18),times=10)


#Add the ranks to bundalldata for home and awayteams

bundalldata <- sqldf("SELECT Div, Date, p1.season, HomeTeam, AwayTeam, FTHG, FTAG, HomeTeamPoints, AwayTeamPoints, p2.Rank as HomeRank, p3.Rank as AwayRank
      FROM bundalldata p1
      LEFT JOIN bundtable p2 ON p1.HomeTeam = p2.Team AND p1.season = p2.season
      LEFT JOIN bundtable p3 ON p1.AwayTeam = p3.Team AND p1.season = p3.season")


#YES!
sqldf("SELECT season, sum(CASE 
      WHEN HomeRank BETWEEN 1 and 6 and AwayRank BETWEEN 15 and 20 THEN AwayTeamPoints
      WHEN HomeRank BETWEEN 15 and 20 and AwayRank BETWEEN 1 and 6 THEN HomeTeamPoints END) AS Bottom6Points
      FROM bundalldata
      GROUP BY season")


#Double Checking sum is correct for 10/11

#Good
sqldf("SELECT season,HomeTeam, AwayTeam, HomeTeamPoints,AwayTeamPoints
      FROM bundalldata WHERE HomeTeam in 
      (SELECT Team from bundtable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') 
      AND AwayTeam in
      (SELECT Team from bundtable WHERE Rank BETWEEN 15 AND 20 and season = '10/11')
      and season = '10/11'
      or HomeTeam in 
      (SELECT Team from bundtable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') 
      AND AwayTeam in
      (SELECT Team from bundtable WHERE Rank BETWEEN 1 AND 6 and season = '10/11')
      AND season = '10/11'")

#Sum only 10/11 - THIS IS RIGHT (after manually checking 1 code block above) 
sqldf("SELECT season,sum(CASE
      WHEN HomeTeam in 
      (SELECT Team from bundtable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') AND AwayTeam in
      (SELECT Team from bundtable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') THEN AwayTeamPoints
      WHEN HomeTeam in 
      (SELECT Team from bundtable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') AND AwayTeam in
      (SELECT Team from bundtable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') THEN HomeTeamPoints END) as Bottom6Points
      FROM bundalldata
      WHERE season = '10/11'")

#Identify leagues winners for last 10 seasons - this becomes much easier after creating the code for big 6 vs bottom 6 below
#SQL
sqldf("SELECT Team as Champion, season
      FROM bundtable 
      WHERE Rank = 1")

#Identify how many times a team has placed top 4 in last 10 seasons 

sqldf("SELECT Team, Count(*) as Top4Finishes
      FROM bundtable 
      WHERE Rank BETWEEN 1 AND 4
      GROUP BY Team
      ORDER by Top4Finishes DESC")

#------------------------------------------------------------------------------------

#Serie A

#Get League Table for all seasons
#Using SQL
sqldf("SELECT Team, sum(Points) as Points, season
          FROM 
          (SELECT HomeTeam as Team, sum(HomeTeamPoints) as Points, season FROM italyalldata GROUP BY Team, season
          UNION
          SELECT AwayTeam as Team, sum(AwayTeamPoints) as Points, season FROM italyalldata GROUP BY Team,season)
      GROUP BY Team, season
      ORDER BY season, Points desc")
#Using R
italyalldata%>%
  select(Team = HomeTeam,Points = HomeTeamPoints, season) %>%
  bind_rows(italyalldata%>%
              select(Team = AwayTeam,Points = AwayTeamPoints, season))%>%
  group_by(Team, season)%>%
  summarise(Points = sum(Points))%>%
  arrange(season, desc(Points))%>%
  print(n = 200)
#its nice to separate the seasons, but if we do it rMarkdown, ill see about adding that
#i dont want to write it out separately right now


#identify bottom 6 points vs top 6 per season

#make table for all 10 seasons and add position in table (Rank) for team during a season
italytable <- as.data.frame(sqldf("SELECT Team, sum(Points) as Points, season
          FROM 
          (SELECT HomeTeam as Team, sum(HomeTeamPoints) as Points, season FROM italyalldata GROUP BY Team, season
          UNION
          SELECT AwayTeam as Team, sum(AwayTeamPoints) as Points, season FROM italyalldata GROUP BY Team,season)
      GROUP BY Team, season
      ORDER BY season, Points desc"))

italytable$Rank <-rep(c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),times=10)


#Add the ranks to italyalldata for home and awayteams

italyalldata <- sqldf("SELECT Div, Date, p1.season, HomeTeam, AwayTeam, FTHG, FTAG, HomeTeamPoints, AwayTeamPoints, p2.Rank as HomeRank, p3.Rank as AwayRank
      FROM italyalldata p1
      LEFT JOIN italytable p2 ON p1.HomeTeam = p2.Team AND p1.season = p2.season
      LEFT JOIN italytable p3 ON p1.AwayTeam = p3.Team AND p1.season = p3.season")


#YES!
sqldf("SELECT season, sum(CASE 
      WHEN HomeRank BETWEEN 1 and 6 and AwayRank BETWEEN 15 and 20 THEN AwayTeamPoints
      WHEN HomeRank BETWEEN 15 and 20 and AwayRank BETWEEN 1 and 6 THEN HomeTeamPoints END) AS Bottom6Points
      FROM italyalldata
      GROUP BY season")


#Double Checking sum is correct for 10/11

#Good
sqldf("SELECT season,HomeTeam, AwayTeam, HomeTeamPoints,AwayTeamPoints
      FROM italyalldata WHERE HomeTeam in 
      (SELECT Team from italytable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') 
      AND AwayTeam in
      (SELECT Team from italytable WHERE Rank BETWEEN 15 AND 20 and season = '10/11')
      and season = '10/11'
      or HomeTeam in 
      (SELECT Team from italytable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') 
      AND AwayTeam in
      (SELECT Team from italytable WHERE Rank BETWEEN 1 AND 6 and season = '10/11')
      AND season = '10/11'")

#Sum only 10/11 - THIS IS RIGHT (after manually checking 1 code block above) 
sqldf("SELECT season,sum(CASE
      WHEN HomeTeam in 
      (SELECT Team from italytable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') AND AwayTeam in
      (SELECT Team from italytable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') THEN AwayTeamPoints
      WHEN HomeTeam in 
      (SELECT Team from italytable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') AND AwayTeam in
      (SELECT Team from italytable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') THEN HomeTeamPoints END) as Bottom6Points
      FROM italyalldata
      WHERE season = '10/11'")

#Identify leagues winners for last 10 seasons - this becomes much easier after creating the code for big 6 vs bottom 6 below
#SQL
sqldf("SELECT Team as Champion, season
      FROM italytable 
      WHERE Rank = 1")

#Identify how many times a team has placed top 4 in last 10 seasons 

sqldf("SELECT Team, Count(*) as Top4Finishes
      FROM italytable 
      WHERE Rank BETWEEN 1 AND 4
      GROUP BY Team
      ORDER by Top4Finishes DESC")

#------------------------------------------------------------------------------------

#La Liga

#Get League Table for all seasons
#Using SQL
sqldf("SELECT Team, sum(Points) as Points, season
          FROM 
          (SELECT HomeTeam as Team, sum(HomeTeamPoints) as Points, season FROM laligaalldata GROUP BY Team, season
          UNION
          SELECT AwayTeam as Team, sum(AwayTeamPoints) as Points, season FROM laligaalldata GROUP BY Team,season)
      GROUP BY Team, season
      ORDER BY season, Points desc")
#Using R
laligaalldata%>%
  select(Team = HomeTeam,Points = HomeTeamPoints, season) %>%
  bind_rows(laligaalldata%>%
              select(Team = AwayTeam,Points = AwayTeamPoints, season))%>%
  group_by(Team, season)%>%
  summarise(Points = sum(Points))%>%
  arrange(season, desc(Points))%>%
  print(n = 200)
#its nice to separate the seasons, but if we do it rMarkdown, ill see about adding that
#i dont want to write it out separately right now


#identify bottom 6 points vs top 6 per season

#make table for all 10 seasons and add position in table (Rank) for team during a season
laligatable <- as.data.frame(sqldf("SELECT Team, sum(Points) as Points, season
          FROM 
          (SELECT HomeTeam as Team, sum(HomeTeamPoints) as Points, season FROM laligaalldata GROUP BY Team, season
          UNION
          SELECT AwayTeam as Team, sum(AwayTeamPoints) as Points, season FROM laligaalldata GROUP BY Team,season)
      GROUP BY Team, season
      ORDER BY season, Points desc"))

laligatable$Rank <-rep(c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),times=10)


#Add the ranks to laligaalldata for home and awayteams

laligaalldata <- sqldf("SELECT Div, Date, p1.season, HomeTeam, AwayTeam, FTHG, FTAG, HomeTeamPoints, AwayTeamPoints, p2.Rank as HomeRank, p3.Rank as AwayRank
      FROM laligaalldata p1
      LEFT JOIN laligatable p2 ON p1.HomeTeam = p2.Team AND p1.season = p2.season
      LEFT JOIN laligatable p3 ON p1.AwayTeam = p3.Team AND p1.season = p3.season")


#YES!
sqldf("SELECT season, sum(CASE 
      WHEN HomeRank BETWEEN 1 and 6 and AwayRank BETWEEN 15 and 20 THEN AwayTeamPoints
      WHEN HomeRank BETWEEN 15 and 20 and AwayRank BETWEEN 1 and 6 THEN HomeTeamPoints END) AS Bottom6Points
      FROM laligaalldata
      GROUP BY season")


#Double Checking sum is correct for 10/11

#Good
sqldf("SELECT season,HomeTeam, AwayTeam, HomeTeamPoints,AwayTeamPoints
      FROM laligaalldata WHERE HomeTeam in 
      (SELECT Team from laligatable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') 
      AND AwayTeam in
      (SELECT Team from laligatable WHERE Rank BETWEEN 15 AND 20 and season = '10/11')
      and season = '10/11'
      or HomeTeam in 
      (SELECT Team from laligatable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') 
      AND AwayTeam in
      (SELECT Team from laligatable WHERE Rank BETWEEN 1 AND 6 and season = '10/11')
      AND season = '10/11'")

#Sum only 10/11 - THIS IS RIGHT (after manually checking 1 code block above) 
sqldf("SELECT season,sum(CASE
      WHEN HomeTeam in 
      (SELECT Team from laligatable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') AND AwayTeam in
      (SELECT Team from laligatable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') THEN AwayTeamPoints
      WHEN HomeTeam in 
      (SELECT Team from laligatable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') AND AwayTeam in
      (SELECT Team from laligatable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') THEN HomeTeamPoints END) as Bottom6Points
      FROM laligaalldata
      WHERE season = '10/11'")

#Identify leagues winners for last 10 seasons - this becomes much easier after creating the code for big 6 vs bottom 6 below
#SQL
sqldf("SELECT Team as Champion, season
      FROM laligatable 
      WHERE Rank = 1")

#Identify how many times a team has placed top 4 in last 10 seasons 

sqldf("SELECT Team, Count(*) as Top4Finishes
      FROM laligatable 
      WHERE Rank BETWEEN 1 AND 4
      GROUP BY Team
      ORDER by Top4Finishes DESC")

#--------------------------------------------------------------------------------------

#ligue 1

#Get League Table for all seasons
#Using SQL
sqldf("SELECT Team, sum(Points) as Points, season
          FROM 
          (SELECT HomeTeam as Team, sum(HomeTeamPoints) as Points, season FROM frenchalldata GROUP BY Team, season
          UNION
          SELECT AwayTeam as Team, sum(AwayTeamPoints) as Points, season FROM frenchalldata GROUP BY Team,season)
      GROUP BY Team, season
      ORDER BY season, Points desc")
#Using R
frenchalldata%>%
  select(Team = HomeTeam,Points = HomeTeamPoints, season) %>%
  bind_rows(frenchalldata%>%
              select(Team = AwayTeam,Points = AwayTeamPoints, season))%>%
  group_by(Team, season)%>%
  summarise(Points = sum(Points))%>%
  arrange(season, desc(Points))%>%
  print(n = 200)
#its nice to separate the seasons, but if we do it rMarkdown, ill see about adding that
#i dont want to write it out separately right now


#identify bottom 6 points vs top 6 per season

#make table for all 10 seasons and add position in table (Rank) for team during a season
frenchtable <- as.data.frame(sqldf("SELECT Team, sum(Points) as Points, season
          FROM 
          (SELECT HomeTeam as Team, sum(HomeTeamPoints) as Points, season FROM frenchalldata GROUP BY Team, season
          UNION
          SELECT AwayTeam as Team, sum(AwayTeamPoints) as Points, season FROM frenchalldata GROUP BY Team,season)
      GROUP BY Team, season
      ORDER BY season, Points desc"))

frenchtable$Rank <-rep(c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),times=10)


#Add the ranks to frenchalldata for home and awayteams

frenchalldata <- sqldf("SELECT Div, Date, p1.season, HomeTeam, AwayTeam, FTHG, FTAG, HomeTeamPoints, AwayTeamPoints, p2.Rank as HomeRank, p3.Rank as AwayRank
      FROM frenchalldata p1
      LEFT JOIN frenchtable p2 ON p1.HomeTeam = p2.Team AND p1.season = p2.season
      LEFT JOIN frenchtable p3 ON p1.AwayTeam = p3.Team AND p1.season = p3.season")


#YES!
sqldf("SELECT season, sum(CASE 
      WHEN HomeRank BETWEEN 1 and 6 and AwayRank BETWEEN 15 and 20 THEN AwayTeamPoints
      WHEN HomeRank BETWEEN 15 and 20 and AwayRank BETWEEN 1 and 6 THEN HomeTeamPoints END) AS Bottom6Points
      FROM frenchalldata
      GROUP BY season")


#Double Checking sum is correct for 10/11

#Good
sqldf("SELECT season,HomeTeam, AwayTeam, HomeTeamPoints,AwayTeamPoints
      FROM frenchalldata WHERE HomeTeam in 
      (SELECT Team from frenchtable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') 
      AND AwayTeam in
      (SELECT Team from frenchtable WHERE Rank BETWEEN 15 AND 20 and season = '10/11')
      and season = '10/11'
      or HomeTeam in 
      (SELECT Team from frenchtable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') 
      AND AwayTeam in
      (SELECT Team from frenchtable WHERE Rank BETWEEN 1 AND 6 and season = '10/11')
      AND season = '10/11'")

#Sum only 10/11 - THIS IS RIGHT (after manually checking 1 code block above) 
sqldf("SELECT season,sum(CASE
      WHEN HomeTeam in 
      (SELECT Team from frenchtable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') AND AwayTeam in
      (SELECT Team from frenchtable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') THEN AwayTeamPoints
      WHEN HomeTeam in 
      (SELECT Team from frenchtable WHERE Rank BETWEEN 15 AND 20 and season = '10/11') AND AwayTeam in
      (SELECT Team from frenchtable WHERE Rank BETWEEN 1 AND 6 and season = '10/11') THEN HomeTeamPoints END) as Bottom6Points
      FROM frenchalldata
      WHERE season = '10/11'")

#Identify leagues winners for last 10 seasons - this becomes much easier after creating the code for big 6 vs bottom 6 below
#SQL
sqldf("SELECT Team as Champion, season
      FROM frenchtable 
      WHERE Rank = 1")

#Identify how many times a team has placed top 4 in last 10 seasons 

sqldf("SELECT Team, Count(*) as Top4Finishes
      FROM frenchtable 
      WHERE Rank BETWEEN 1 AND 4
      GROUP BY Team
      ORDER by Top4Finishes DESC")

#Graphs/Charts

#1. Points from bottom 6 year over year for each league so show comparison

prembottom6 <- sqldf("SELECT season, sum(CASE 
      WHEN HomeRank BETWEEN 1 and 6 and AwayRank BETWEEN 15 and 20 THEN AwayTeamPoints
      WHEN HomeRank BETWEEN 15 and 20 and AwayRank BETWEEN 1 and 6 THEN HomeTeamPoints END) AS PremBottom6Points
      FROM premalldata
      GROUP BY season")

bundbottom6 <- sqldf("SELECT season, sum(CASE 
      WHEN HomeRank BETWEEN 1 and 6 and AwayRank BETWEEN 15 and 20 THEN AwayTeamPoints
      WHEN HomeRank BETWEEN 15 and 20 and AwayRank BETWEEN 1 and 6 THEN HomeTeamPoints END) AS BundBottom6Points
      FROM bundalldata
      GROUP BY season")

italybottom6 <-  sqldf("SELECT season, sum(CASE 
      WHEN HomeRank BETWEEN 1 and 6 and AwayRank BETWEEN 15 and 20 THEN AwayTeamPoints
      WHEN HomeRank BETWEEN 15 and 20 and AwayRank BETWEEN 1 and 6 THEN HomeTeamPoints END) AS ItalyBottom6Points
      FROM italyalldata
      GROUP BY season")

laligabottom6 <- sqldf("SELECT season, sum(CASE 
      WHEN HomeRank BETWEEN 1 and 6 and AwayRank BETWEEN 15 and 20 THEN AwayTeamPoints
      WHEN HomeRank BETWEEN 15 and 20 and AwayRank BETWEEN 1 and 6 THEN HomeTeamPoints END) AS LaLigaBottom6Points
      FROM laligaalldata
      GROUP BY season")

frenchbottom6 <-  sqldf("SELECT season, sum(CASE 
      WHEN HomeRank BETWEEN 1 and 6 and AwayRank BETWEEN 15 and 20 THEN AwayTeamPoints
      WHEN HomeRank BETWEEN 15 and 20 and AwayRank BETWEEN 1 and 6 THEN HomeTeamPoints END) AS FrenchBottom6Points
      FROM frenchalldata
      GROUP BY season")

bottom6 <- prembottom6%>%
  left_join(bundbottom6, by = "season")%>%
  left_join(italybottom6, by = "season")%>%
  left_join(laligabottom6, by = "season")%>%
  left_join(frenchbottom6, by = "season")


bottom6 <-  bottom6%>%
  pivot_longer(!season, names_to = "League",
               values_to = "Points")

ggplot(bottom6)+
  geom_line(aes(x = season, y = Points, group = League, color = League))+
  geom_point(aes(x = season, y = Points, group = League, color = League))+
  ggtitle("Points Earned per Season from Bottom 6 Teams vs \n Top 6 Teams in Europe: 09/10 - 18/19")

#So what does this tell us? Well, that there isnt much in it
#You might notice the bundlesliga on multiple occasions is at the bottom of these rankins and never at the top
#You might notice the french league is on top on multiple occasions and never at the bottom
#And then you have the Prem, Italian Serie A and Spanish La Liga all hovering in the middle each having a couple occasions where theyre on top and a couple occasions where theyre on the bottom

#Meaning what? Well that soccer is a sport. None of these top sides completely obliterate the bottom sides year after year, nor lose more often to bottom sides year after year. 
#The media frenzy that anyone can beat anyone on any given day in the premier league is probably true. 
#But no more true that any of the other leagues. You just hear about a result more in the premier league because it has the most global media attention and marketing


