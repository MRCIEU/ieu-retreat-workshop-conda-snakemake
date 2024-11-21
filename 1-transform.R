library("tidyverse")

args = commandArgs(trailingOnly=TRUE)

INPUT_FILE = args[1]
COUNTRY_CODE = args[2]
OUTPUT_FILE = args[3]
print(
  glue::glue("INPUT_FILE {INPUT_FILE}\nCOUNTRY_CODE {COUNTRY_CODE} OUTPUT_FILE {OUTPUT_FILE}")
)

df = read_csv(INPUT_FILE)

df %>%
  filter(Country_code %in% COUNTRY_CODE) %>%
  select(date=Date_reported,
         country=Country,
         cases=New_cases, deaths=New_deaths) ->
  clean_df

clean_df %>% glimpse()

clean_df %>% write_csv(OUTPUT_FILE)
