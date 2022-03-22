## Punting analytics
## January 2022
## Dave Moyer

library(tidyverse)
library(nflfastR)

setwd("C:/Users/dmoyer.3SI/personal/punting")

pbp_2020 <- load_pbp(2020)

punt_2020 <- pbp_2020 %>%
  filter((play_type == "punt" & punt_blocked == 0 )| 
           (drive_start_transition %in% c("MUFFED_PUNT","PUNT") & drive_play_id_started == play_id)) %>%
  arrange(game_id, play_id) %>%
  select(play_id,
         game_id,
         posteam,
         defteam,
         quarter_seconds_remaining,
         half_seconds_remaining,
         game_seconds_remaining,
         qtr,
         down,
         ydstogo,
         yrdln,
         time,
         play_type,
         desc,
         penalty,
         starts_with("punt"))

kickoff_2020 <- pbp_2020 %>%
  filter(play_type == "kickoff") %>%
  select(play_id,
         game_id,
         posteam,
         defteam,
         quarter_seconds_remaining,
         half_seconds_remaining,
         game_seconds_remaining,
         qtr,
         down,
         ydstogo,
         yrdln,
         time,
         play_type,
         desc,
         starts_with("kick"),
         touchback,
         starts_with("return"))

## kickoff runbacks
pct_touchbacks <- kickoff_2020 %>%
  summarise(pct = mean(touchback, na.rm = T))
print(pct_touchbacks)

pct_touchbacks_kicker <- kickoff_2020 %>%
  group_by(kicker_player_name) %>%
  summarise(pct = mean(touchback, na.rm = T))
print(pct_touchbacks)

