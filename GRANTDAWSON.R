#Link: https://x.com/alexvikatos/status/1707091105605406954?s=20
#Author : Alex Vikatos



#grant dawson#
Dawson=data.frame(
  fight=c("Grant Dawson vs Nad Narimani","Grant Dawson vs Leonardo Santos","Grant Dawson vs Ricky Glenn", "Grant Dawson vs Jared Gordon","Gran Dawson vs Mark Madsen","Grant Dawson vs Damir Ismagulov"),
  control_time=c(491,498,506,431,571,744),
  takedowns_landed=c(2,1,3,7,2,3)
)
Dawson
plot(Dawson$control_time,Dawson$takedowns_landed)
barplot(Dawson$control_time)

library(ggplot2)
d=ggplot(Dawson,aes(fight,(Dawson$control_time)))
d+geom_bar(stat = "identity",width = 0.5,fill="orange1")+labs(title="Grant Dawson's Control Time in His Last 6 Fights",x="Fight",y="Seconds")+
  theme(axis.text.x =element_text(angle=90,vjust=0.6) )+coord_flip() + theme_economist()
