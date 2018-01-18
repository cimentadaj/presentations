# Download the package from CRAN
install.packages("ess")
install.packages("tidyverse")

library(ess)
library(tidyverse)


# Explore which rounds are available
show_rounds()

# Choose the ones you're interested
all_rnds <- ess_rounds(1:8, "your_registered@email.com")

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
  geom_line()

# Very little effort!


# Explore which country/rounds are available
show_countries()

# Let's work with Spain but how many rounds has it participated in?
show_country_rounds("Spain")

# Then let's download it
ess_three <- ess_country("Spain", 3, "your_registered@email.com")

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
  attr(all_rnds[[1]]$regioaes, "labels") %>%
  {setNames(names(.), .)}

# correct for the wrong encoding
labels_reg <- iconv(labels_reg, "latin1", "UTF-8")

region_es %>%
  mutate(region = labels_reg[region]) %>% # recoding region form number to character
  group_by(region = as.factor(region)) %>% # create as factor
  summarize(avg_age = first(avg_ageb)) %>% # get the avg age of first birth
  ggplot(aes(x = reorder(region, avg_age), y = avg_age)) +
  geom_col() +
  coord_flip()

### Downloading files

ess_rounds(1:3, "your_registered@email.com", only_download = TRUE, output_dir = getwd())

ess_country("Denmark", c(2, 3),
            "your_registered@email.com",
            only_download = TRUE,
            output_dir = getwd())