#Link : https://x.com/alexvikatos/status/1706078860138189094?s=20
#Author : Alex Vikatos


#gamrot Twitter#
Gamrot=data.frame(
  fight=c("Gamrot vs Kutateladze","Gamrot vs Fereira","Gamrot vs Dariush","Gamrot vs Tsarukyan","Gamrot vs Turner","Gamrot vs Fiziev"),
  Gamrot_takedowns_attempts=c(16,7,19,21,12,6),
  Gamrot_takedowns_landed=c(5,4,4,6,4,1)
  )

       
library(ggplot2)
library(ggthemes)
g=ggplot(Gamrot,aes(fight,Gamrot$Gamrot_takedowns_attempts))
g+geom_bar(stat = "identity",width = 0.5,fill="tomato2")+labs(title="Gamrot Takedowns Attempts Barplot",x="Fight",y="Takedown Attempts")+
theme(axis.text.x =element_text(angle=45,vjust=0.6) )+theme_wsj()+coord_flip()
  
