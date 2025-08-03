# mini dashboard in R (no Power BI)
# Usage in terminal or Posit Cloud:
#   source("dashboard_R.R")

suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(readr)
})

df <- read_csv("sales_demo.csv", show_col_types = FALSE)

# KPI
total_sales <- sum(df$SalesAmount, na.rm = TRUE)
cat(sprintf("KPI - Total Sales: $%s\n", format(round(total_sales,2), big.mark=",", trim=TRUE)))

# Donut chart: share by category
cat_sales <- df %>%
  group_by(ProductCategory) %>%
  summarise(Total = sum(SalesAmount, na.rm = TRUE))

p <- ggplot(cat_sales, aes(x = 2, y = Total, fill = ProductCategory)) +
  geom_bar(stat = "identity") +
  coord_polar(theta = "y") +
  xlim(0.5, 2.5) +
  theme_void() +
  ggtitle("Sales Share by Product Category")

ggsave("donut_by_category.png", plot = p, width = 6, height = 6, dpi = 150)
cat("Saved chart: donut_by_category.png\n")