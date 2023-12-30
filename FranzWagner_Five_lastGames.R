
##Link : https://x.com/alexvikatos/status/1731390768139342037?s=20
##Author : Alex Vikatos
## Sources : Andrew Mack



# Creating a data frame for Franz Wagner for the 2023-24 Last Five Games
FranzWagner <- data.frame(
  points = c(17,30,31,31,20),
  minutes = c(35,35,31,34,34)
)

# Print the data frame
print(FranzWagner)

#Creating New Variables (points per minute=PPM)
FranzWagner$PPM=FranzWagner$points/FranzWagner$minutes

##Define prior distribution mean & stdev
prior_ppm_mean=mean(FranzWagner$PPM)
prior_ppm_sd=sd(FranzWagner$PPM)
prior_minutes_mean=mean(FranzWagner$minutes)
prior_minutes_sd=sd(FranzWagner$minutes)



#Define Stan model
model_code <- "
data {
real minutes_mean;
real minutes_sd;
real ppm_mean;
real ppm_sd;
}
parameters {
real minutes;
real ppm;
}
model {
// Priors
minutes ~ normal(minutes_mean, minutes_sd);
ppm ~ normal(ppm_mean, ppm_sd);
}
generated quantities {
real points = minutes * ppm;
}
"
#Compile model
model <- stan_model(model_code = model_code)

#Generate posterior samples
posterior_samples <- sampling(model, data = list(minutes_mean = prior_minutes_mean,
                                                 minutes_sd = prior_minutes_sd,
                                                 ppm_mean = prior_ppm_mean,
                                                 ppm_sd = prior_ppm_sd),
                              chains = 4, iter = 1000, warmup = 500, thin = 2)

#Extract posterior samples for expected points
posterior_points <- extract(posterior_samples)$points

#Plot posterior distribution of expected points
hist(posterior_points, breaks = 50, xlab = "Expected Points", ylab = "Frequency")

median(posterior_points) # Median of distribution
mean(posterior_points > 26.5) # probability of observing more than 26.5
mean(posterior_points < 26.5)

library(ggthemes)
library(ggplot2)

#Histogram
ggplot(data=data.frame(posterior_points),aes(x=posterior_points))+
  geom_histogram(aes(y=..density..),bins = 40,color="black",fill="cadetblue")+
  labs(title = "Franz Wagner:Posterior Distribution of Expected Points",x="Expected Points",y="Frequency")+
  theme_economist_white()+
  geom_vline(aes(xintercept=mean(posterior_points)),color="black",linetype="dashed",size=1)+
  geom_density(alpha=.4)
  











