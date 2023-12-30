#Author: Alex Vikatos



library(tidyverse)
library(glue)
library(gt)
library(gtExtras)
library(hoopR)

df = load_nba_player_box(seasons = most_recent_nba_season())
df = df[, c(6, 7, 9, 12:18, 28, 36, 42)]

df1 = df %>%
  filter(minutes > 20) %>%
  group_by(athlete_display_name, athlete_id, athlete_headshot_href) %>%
  summarize(
    total_minutes = sum(minutes),
    total_points = sum(points),
    total_field_goals_made = sum(field_goals_made),
    total_field_goals_attempted = sum(field_goals_attempted),
    total_three_point_field_goals_attempted = sum(three_point_field_goals_attempted),
    total_three_point_field_goals_made = sum(three_point_field_goals_made),
    total_free_throws_attempted = sum(free_throws_attempted),
    total_free_throws_made = sum(free_throws_made),
    EFG = (total_field_goals_made + 0.5 * total_three_point_field_goals_made) / (total_field_goals_attempted + total_three_point_field_goals_attempted)
  ) 

# Table creation
df1 %>%
  select(athlete_display_name,athlete_id,EFG,total_points, EFG) %>%
  arrange(desc(total_points)) %>%
  group_by(athlete_display_name) %>%
  mutate(athlete_id = glue("https://a.espncdn.com/i/headshots/nba/players/full/{athlete_id}.png")) %>%
  ungroup()%>%
  head(10) %>%
  gt() %>%
  gt_img_rows(columns = 2, height = 25) %>%
  fmt_number(columns = c(EFG),decimals = 2)%>%
  tab_footnote(footnote="Author: Alex Vikatos")%>%
  cols_label(athlete_display_name = "Name", EFG = "EFG",athlete_id="",total_points="TOTAL POINTS") %>%
  tab_header(title = "Exploring the EFG of the Top-10 NBA Scorers",subtitle = "Data:hoopR/NBAstats") %>%
  tab_options(data_row.padding = px(10), heading.title.font.size = 18, heading.subtitle.font.size = 16, table.font.size = 15)%>%
  tab_style(style=list(cell_text(weight = "bold")),locations = cells_body(columns=c(athlete_display_name,EFG,total_points)))
                                                   

