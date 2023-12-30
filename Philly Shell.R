#Link: https://x.com/alexvikatos/status/1701269922192519655?s=20
#Author : Alex Vikatos



# Create a data frame with the provided data
# Create a data frame with the provided data
df <- data.frame(
  Fight = c("UFC 259 : ADESANYA VS JAN BLACHOWICZ", "UFC 263 : ADESANYA VS VETTORI 2", "UFC 248 : ADESANYA VS ROMERO", "UFC 271 : ADESANYA VS WHITTAKER 2", "UFC 276 : ADESANYA VS CANNONIER", "UFC 293 : ADESANYA VS STRICKLAND"),
  Adesanya_Total_Strikes_Attempts = c(182, 208, 132, 188, 277, 271),
  Adesanya_Total_Strikes_Landed = c(99, 122, 48, 98, 163, 94),
  Opponent_Total_Strikes_Attempts = c(276, 211, 89, 151, 241, 259),
  Opponent_Total_Strikes_Landed = c(184, 91, 40, 74, 147, 137)
)

# Display the data frame
print(df)


head(df)

# Load the tidyr package
library(tidyr)

# Reshape the data into a longer format
df_long <- df %>%
  pivot_longer(
    cols = c("Adesanya_Total_Strikes_Landed", "Adesanya_Total_Strikes_Attempts", "Opponent_Total_Strikes_Landed", "Opponent_Total_Strikes_Attempts"),
    names_to = "Strike_Type",
    values_to = "Value"
  )

# Create the grouped barplot
ggplot(df_long, aes(x = Fight, y = Value, fill = Strike_Type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Adesanya Total Strikes vs. Opponent Total Strikes",
       x = "Fight",
       y = "Count") +
  theme_stata() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = c("blue", "cadetblue", "red", "orange"))  # Custom colors for the bars

