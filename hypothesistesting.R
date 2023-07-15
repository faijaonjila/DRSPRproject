### load required libraries
library(dplyr)
starwars

##comparing the mass of male and female human star wars characters
## null hypothesis: average mass of male and female star wars characters is the same
## alternative hypothesis: average mass of male and female star war characters is different 
swhumans <- starwars |> filter(species == "Human", mass > 0)
males <- swhumans |> filter(sex == "male")
females <- swhumans |> filter(sex == "female")

t.test(males$mass, female$mass, paired = F)
# p value is 0.06
# not significant, failed to reject null hypothesis


## ANOVA ####
iris

anova_results <- aov(data = iris, Sepal.Width ~ Species )
anova_results

## Are any groups different from each other?
summary(anova_results)


## Which ones?
TukeyHSD(anova_results)

## Is there a significant in the mean petal lengths or petal widths by species?

anovatest <- aov(data = iris, Petal.Length ~ Species)
summary(anovatest)
TukeyHSD(anovatest)

anovawidth <- aov(data = iris, Petal.Width ~ Species)
summary(anovawidth)
TukeyHSD(anovawidth)


library(dplyr)
head(starwars)
unique(starwars$species)

## Which 5 species are the most common?

top3species <- starwars |>
  summarize(.by = species,
            count = n()) |>
  slice_max(count, n = 3)

top3species

top3species <- starwars |>
  summarize(.by = species,
            count = sum(! is.na(species))) |>
  slice_max(count, n = 3)

top3species

starwars_top3species <- starwars |>
  filter(species %in% top3species)

starwars_top3species

## Is there a significant difference in the mass of each of the top 3 species?
aa  <- aov(height ~ species, starwars_top3species )
summary(aa)
TukeyHSD(aa)

## Chi-Squared ####
starwars_clean <- starwars |>
  filter(! is.na(species), 
         ! is.na(homeworld))


t <- table(starwars$species , starwars$homeworld)
chisq.test(t) # not enough data

library(ggplot2)

mpg
table(mpg$manufacturer, mpg$class)
table(mpg$cyl, mpg$displ)

## How do we get a contingency table of year and drv?
t <- table(mpg$year, mpg$drv)

chisq_result <- chisq.test(t)
chisq_result
chisq_result$p.value
chisq_result$residuals

install.packages("corrplot")
library(corrplot)

corrplot(chisq_result$residuals)

## chi-squared full analysis
heroes
head(heroes)

## clean data
heroes_clean <- heroes |>
  filter(Alignment != "-",
         Gender != "-")
## plot the counts of the alignment and gender
ggplot(heroes_clean, aes(x= Gender, y = Alignment)) +
  geom_count() +
  theme_minimal()
## make contingency table
t <- table(heroes_clean$Alignment, heroes_clean$Gender)
t

## chi squared test
chi <- chisq.test(t)
chi$p.value
chi$residuals

corrplot(chi$residuals, is.cor = F)
