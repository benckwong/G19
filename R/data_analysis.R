library(ggplot2)
product_data <- read.csv("Data_upload/product.csv")
gg <- ggplot(product_data, aes(x = price, y = discount_rate)) +
  geom_point() +
  labs(title = "Price vs. Discount Rate",
       x = "Price",
       y = "Discount Rate")

if (!file.exists("figures")) {
  dir.create("figures")
}
ggsave("figure/price_vs_discount.png", plot = gg)
