library("tidyverse")

args = commandArgs(trailingOnly=TRUE)

INPUT_FILE = args[1]
OUTPUT_FILE = args[2]
print(
  glue::glue("INPUT_FILE {INPUT_FILE}\n OUTPUT_FILE {OUTPUT_FILE}")
)

df = read_csv(INPUT_FILE)

plot_df = df %>%
  pivot_longer(cols=c("cases", "deaths"), names_to="value_category", values_to="value")


fig = plot_df %>%
  ggplot(aes(x=date, y=value)) +
  geom_line(aes(colour=value_category)) +
  facet_wrap(value_category ~ country, scales="free")

fig %>% ggsave(filename=OUTPUT_FILE, plot=.)
