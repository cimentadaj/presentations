
install.packages(c("essurvey", "ggplot2", "dplyr", "purrr"))

library(essurvey)
library(ggplot2)
library(purrr)
library(dplyr)

# Saves your email to log in to the ESS website
set_email("cimentadaj@gmail.com")

show_rounds()

show_countries()

show_country_rounds("Spain")


## Let's explore country rounds

spn <- import_country("Spain", rounds = 2)

## ESS round 2
unique(spn$essround)

## Confirm it's Spain
unique(spn$cntry)

## Let's explore whether Spaniards trust their legal system
attr(spn$trstlgl, "label")

## Are there any categories that represent missing values?
attr(spn$trstlgl, "labels")

## We can recode them with recode_missings
spn <- recode_missings(spn)

## They've been set as missing values
attr(spn$trstlgl, "labels")

## Let's turn it into a categorical variable
spn$trstlgl <- factor(spn$trstlgl, ordered = TRUE)

## Let's visualize the response
ggplot(spn, aes(trstlgl)) +
  geom_bar() +
  labs(x = "Trust in the legal systemin Spain") +
  theme_minimal()

## Only 7 rounds of code to visualize that!
spn <- import_country("Spain", rounds = 2)
spn <- recode_missings(spn)
spn$trstlgl <- factor(spn$trstlgl, ordered = TRUE)
ggplot(spn, aes(trstlgl)) +
  geom_bar() +
  labs(x = "Trust in the legal systemin Spain") +
  theme_minimal()

## What if we wanted to explore this overtime? That is, we want to look
## at the percentage of people in each category for all available rounds
## for Spain?

## This reads ALL avilable rounds for Spain by default
all_rounds <- import_all_cntrounds("Spain")

## Correct all rounds for the missing values
all_rounds_no_miss <- map(all_rounds, recode_missings)

## Merge all rounds into one dataset and only keep the round variable
## and the trust in legal system variable
all_rounds_merged <- map_df(all_rounds_no_miss, ~ .x[c('essround', 'trstlgl')])

all_rounds_merged$trstlgl <- factor(all_rounds_merged$trstlgl, ordered = TRUE)
all_rounds_merged$essround <- factor(all_rounds_merged$essround, ordered = TRUE)

all_rounds_merged %>% 
  count(essround, trstlgl) %>% 
  group_by(essround) %>% 
  mutate(percentage = round(n / sum(n), 2)) %>% 
  filter(trstlgl %in% c(0, 5, 10)) %>% 
  ggplot(aes(essround, percentage, colour = trstlgl, group = trstlgl)) +
  geom_line(size = 2) +
  labs(x = "ESS Rounds",
       y = "Percentage") +
  scale_color_discrete(name = "Trust in legal system",
                       labels = c('No trust', 'More or less trust', 'High trust')) +
  ggtitle("Proportion of respondents who trust the legal system") +
  theme_minimal()


## What if we wanted to compare countries that participated only in waves
## 2, 4 and 8? That's a bit more difficult because we need to check which
## countries where in round 2, then in round 4 etc.. and then check
## which ones are common.

## For example: https://www.europeansocialsurvey.org/data/country_index.html

rounds <- c(2, 4, 8)
## essurvey has got you covered!

# Show me only 9 countries that participated in rounds 2, 4 and 8
countries <- show_rounds_country(rounds)[1:9]

countries

# Let's explore the same question for these countries

# Download all rounds and recode missings
all_country_rounds <- map(countries, ~ lapply(import_country(.x, rounds), recode_missings))

# Merge all datasets and only choose the three columns of interest
all_countries <- map_df(flatten(all_country_rounds), ~ .x[c('essround', 'cntry', 'trstlgl')])

# We can recycle the same code from the previous plot

all_countries$trstlgl <- factor(all_countries$trstlgl, ordered = TRUE)
all_countries$essround <- factor(all_countries$essround, ordered = TRUE)

all_countries %>% 
  count(essround, cntry, trstlgl) %>% 
  group_by(essround, cntry) %>% 
  mutate(percentage = round(n / sum(n), 2)) %>% 
  filter(trstlgl %in% c(0, 5, 10)) %>% 
  ggplot(aes(essround, percentage, colour = trstlgl, group = trstlgl)) +
  geom_line(size = 1) +
  labs(x = "ESS Rounds",
       y = "Percentage") +
  scale_color_discrete(name = "Trust in legal system",
                       labels = c('No trust', 'More or less trust', 'High trust')) +
  ggtitle("Proportion of respondents who trust the legal system") +
  facet_wrap(~ cntry) +
  theme_minimal() +
  theme(legend.position = "top")


## What if we want to download the complete rounds?

round_five <- import_rounds(5)

round_five

## What if we want to download several rounds?

some_rounds <- import_rounds(c(1, 4, 8))

some_rounds

## essurvey allows to download data in SPSS or Stata formats
path_to_save <- "C:\\Users\\cimentadaj\\Downloads"

download_country("Spain", c(1, 2), output_dir = path_to_save, format = 'stata')

download_country("Spain", c(1, 2), output_dir = path_to_save, format = 'stata')

# You can also use download_rounds