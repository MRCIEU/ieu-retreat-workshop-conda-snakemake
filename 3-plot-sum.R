library("tidyverse")

args = commandArgs(trailingOnly=TRUE)

OUTPUT_FILE = args[1]
INPUT_FILES = args[2:length(args)]
print(
  glue::glue("INPUT_FILES {INPUT_FILES}\n")
)
print(
  glue::glue("OUTPUT_FILE {OUTPUT_FILE}")
)

df_list = lapply(INPUT_FILES, function(input_file) read_csv(input_file))
glimpse(df_list)
df = bind_rows(df_list)
glimpse(df)

plot_df = df %>%
  pivot_longer(cols=c("cases", "deaths"), names_to="value_category", values_to="value")


fig = plot_df %>%
  ggplot(aes(x=date, y=value)) +
  geom_line(aes(colour=value_category)) +
  facet_wrap(value_category ~ country, scales="free")

fig %>% ggsave(filename=OUTPUT_FILE, plot=.)
