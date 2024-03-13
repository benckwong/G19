library(ggplot2)

product_data <- read.csv("Data_upload/Product.csv")

# 创建散点图
gg <- ggplot(product_data, aes(x = price, y = discount_rate)) +
  geom_point() +
  labs(title = "Price vs. Discount Rate",
       x = "Price",
       y = "Discount Rate")
if (!file.exists("figure")) {
  dir.create("figure")
}

ggsave("figure/price_vs_discount.png", plot = gg)
