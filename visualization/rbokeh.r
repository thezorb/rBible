install.packages("rbokeh")
data(diamonds, package = 'ggplot2')
head(diamonds)
library(rbokeh)
figure() %>% ly_points(carat, price, data=diamonds)
figure() %>% ly_points(carat, price, data=diamonds, color=cut)
figure() %>% ly_points(carat, price, data=diamonds, color=cut, hover=list(carat, price)) %>%
  ly_lines(lowess(x=carat, y=price), data=diamonds)

figure() %>% ly_points(carat, price, data=diamonds, color=cut, glpyh= cut, alpha = 1/3)

figure() %>% ly_hist(price, data=diamonds, freq=FALSE) %>% ly_denisty(price, data=diamonds)
figure() %>% ly_boxplot(price, cut, data=diamonds) %>% x_axis(label = 'Diamond Cut') %>% 
  y_axis(label='Price', number_formatter ='numeral', format='0,000')
