#Euroleague EFG Table
#Data Source: hackaStat
#Author: Alex Vikatos

library(tidyverse)
library(glue)
library(gt)
library(gtExtras)

euroleague=read.csv(file.choose(),header = TRUE,sep=";")
head(euroleague)
str(euroleague)

euroleague1=euroleague%>%
  group_by(NAME,TM.NAME)%>%
  summarize(
    total_points=sum(PTS),
    total_FGA=sum(FGA),
    total_FGM=sum(FGM),
    total_minutes=sum(MIN),
    total_3pts_made=sum(X3PTM),
    total_2pts_made=sum(X2PTM),
    total_assists=sum(AST)
  )%>%
  mutate(eFG=(total_2pts_made+1.5*(total_3pts_made))/total_FGA)%>%
  arrange(desc(total_points))%>%
  head(10)

team_logo=c("https://media-cdn.incrowdsports.com/89ed276a-2ba3-413f-8ea2-b3be209ca129.png?width=60&height=60&resizeType=fill&format=webp",
            "https://media-cdn.incrowdsports.com/e324a6af-2a72-443e-9813-8bf2d364ddab.png?width=60&height=60&resizeType=fill&format=webp",
            "https://media-cdn.incrowdsports.com/8ea8cec7-d8f7-45f4-a956-d976b5867610.png?width=60&height=60&resizeType=fill&format=webp",
            "https://media-cdn.incrowdsports.com/0aa09358-3847-4c4e-b228-3582ee4e536d.png?width=60&height=60&resizeType=fill&format=webp",
            "https://media-cdn.incrowdsports.com/789423ac-3cdf-4b89-b11c-b458aa5f59a6.png?width=60&height=60&resizeType=fill&format=webp",
            "https://media-cdn.incrowdsports.com/4af5e83b-f2b5-4fba-a87c-1f85837a508a.png?width=60&height=60&resizeType=fill&format=webp",
            "https://media-cdn.incrowdsports.com/0233ebbb-f3a2-49ea-837c-7fd3e661e672.png?width=90&height=90&resizeType=fill&format=webp",
            "https://media-cdn.incrowdsports.com/4af5e83b-f2b5-4fba-a87c-1f85837a508a.png?width=90&height=90&resizeType=fill&format=webp",
            "https://media-cdn.incrowdsports.com/e324a6af-2a72-443e-9813-8bf2d364ddab.png?width=90&height=90&resizeType=fill&format=webp",
            "https://media-cdn.incrowdsports.com/1a3e1404-4f6f-4ede-9d8b-30eee7cb51b4.png?width=90&height=90&resizeType=fill&format=webp"
            )
euroleague1$team_logo=team_logo


#Table Creation
euroleague1%>%
  select(NAME,team_logo,total_minutes,total_points,total_assists,eFG)%>%
  ungroup()%>%
  gt()%>%
  cols_label(NAME = "Name",team_logo="",total_assists="Assists",total_points="Points",eFG="eFG",total_minutes="Minutes") %>%
  tab_header(title = "Exploring the eFG of the Top-10 Euroleague Scorers") %>%
  tab_footnote(footnote = "Data Source : hackaStat")%>%
  tab_footnote(footnote = "Table By: Alex Vikatos")%>%
  gt_img_rows(columns = 2, height = 25) %>%
  fmt_number(c(eFG),decimals = 2)%>%
  gt_highlight_rows(rows = 5,fill="orange",bold_target_only = TRUE)
  tab_options(data_row.padding = px(10), heading.title.font.size = 18, heading.subtitle.font.size = 16, table.font.size = 13)




