# Download the packages from CRAN
install.packages("ess")
install.packages("tidyverse")

library(ess)
library(tidyverse)

# replace this email with your registerd ess email
# if you haven't registered go to: 
# http://www.europeansocialsurvey.org/user/new
your_registered_email <- "your@email.com"

# Explore which rounds are available
show_rounds()

# Choose the ones you're interested
all_rnds <- ess_rounds(1:8, your_registered_email)

### Downloading files

# With these functions you can download the files to your computer
# Currently only Stata files (19/1/2018) but next releases
# will allow Stata, SPSS and SAS.

# For rounds
# ess_rounds(1:3, your_registered_email, only_download = TRUE, output_dir = getwd())

# For countries
# ess_country("Denmark", c(2, 3),
#             your_registered_email,
#             only_download = TRUE,
#             output_dir = getwd())

### Analysis of rounds

# subset only a few variables
filtered_df <- lapply(all_rnds, function(x) x[c("name", "cntry", "pray")])

# Let's merge the data
# filter only some countries and non missing values
filtered_df %>%
  reduce(rbind) %>%
  filter(cntry %in% c("DK", "CZ", "ES"),
         pray <= 7) %>%
  mutate(name = str_extract(name, "^ESS[0-9]{1,}")) %>%
  group_by(name, cntry) %>%
  summarize(avg_pray = mean(pray, na.rm = TRUE)) %>%
  ggplot(aes(name, avg_pray, group = cntry, colour = cntry)) +
  geom_line() +
  labs(title = "Avg agreement to pray outside of church for all ESS rounds",
       subtitle = "Lower scores mean more agreement") +
  ylab("Average agreement to praying outside of church") +
  xlab("ESS rounds")

# Very little effort!

### Analysis of countries

# Explore which country/rounds are available
show_countries()

# Let's work with Spain but how many rounds has it participated in?
show_country_rounds("Spain")

# Then let's download it
ess_three <- ess_country("Spain", 3, your_registered_email)

# Let's merge it with some eurostat data
install.packages("eurostat")
library(eurostat)

all_fertility <- get_eurostat("demo_r_find2")


reg_indicator <-
  all_fertility %>%
  filter(str_detect(geo, "^ES"), # only select ES (Spain)
         time >= "2006-01-01", # we want values from 2006
         time <  "2007-01-01", # to match ESS3
         indic_de == "AGEMOTH") %>% # select age at first birth of mother
  separate(geo, c("cntry", "region"), sep = 2) %>% # create region indicator
  transmute(cntry,
            region = ifelse(region == "", NA, region),
            avg_ageb = values) %>% # clean up
  filter(!is.na(region))

# merge the Spain's third round with the regional data
region_es <-
  ess_three[[1]] %>%
  transmute(cntry,
            region = as.character(regioaes),
            pray) %>%
  filter(cntry == "ES") %>%
  left_join(reg_indicator, c("cntry", "region"))


# get the regional labels
labels_reg <-
  attr(ess_three[[1]]$regioaes, "labels") %>%
  {setNames(names(.), .)}

# correct for the wrong encoding
labels_reg <- iconv(labels_reg, "latin1", "UTF-8")

region_es %>%
  mutate(region = labels_reg[region]) %>% # recoding region form number to character
  group_by(region = as.factor(region)) %>% # create as factor
  summarize(avg_age = first(avg_ageb)) %>% # get the avg age of first birth
  ggplot(aes(x = reorder(region, avg_age), y = avg_age)) +
  geom_col() +
  coord_flip() +
  ylab("Average age of first birth of the mother") +
  xlab("Spanish regions") +
  labs(title = "Average age of first birth of mothers for Spanish regions")
