# Set up ------------------------------------------------------------------

rm(list=ls())
library(ggplot2)



# Read and check data -----------------------------------------------------

lr04 <- read.delim("./data/lr04.txt")
str(lr04)
head(lr04)



# Basic plot --------------------------------------------------------------

ggplot(data=lr04, aes(x=time, y=d18o))+               # set up plot
  geom_line(colour = "#00AFBB", size = 0.3)+          # plot line
  labs(title="LR04 Benthic Stack",                    # plot labels 
       x="Time (ka)", 
       y=expression(δ^{18}*O~"(‰)"),
       caption="Data from Lisiecki & Raymo (2005)")+ 
       scale_y_reverse()+                             # reverse scale on y-axis
       theme_classic()                                # set ggplot theme

# NOTES
# —————
# - Time is plotted in thousands of years but I would prefer millions of years!
# - Lower d18O represent warmer interglacials so I reversed the y axis as it is 
#   more intuitive to see warmer temperatures towards the top.
# - It was difficult to plot the y axis label with symbols and superscipt but I 
#   managed to get it to work.
# - There are several different ggplot themes:
#   https://ggplot2.tidyverse.org/reference/ggtheme.html 
# - These can be tweaked:
#   https://ggplot2.tidyverse.org/reference/theme.html)



# Time in millions of years -----------------------------------------------

lr04$time <- lr04$time/1000 # convert time from ka to ma

ggplot(data=lr04, aes(x=time, y=d18o))+
  geom_line(colour = "#00AFBB", size = 0.3)+
  labs(title="LR04 Benthic Stack",
       x="Time (Ma)", 
       y=expression(δ^{18}*O~"(‰)"),                 
       caption="Data from Lisiecki & Raymo (2005)")+ 
  scale_y_reverse()+                                 # reverse scale on y-axis
  theme_classic()      

# NOTES
# —————
# I had originally reversed the x-axis using scale_x_reverse() as this makes 
# more sense (going from older on the left to younger on the right) but this 
# doesn't seem to be the done thing for this type of data. All plots I have seen 
# show it going from younger to older, left to right.



# Line colour as gradient -------------------------------------------------

ggplot(data=lr04, aes(x=time, y=d18o, colour=d18o))+ 
  geom_line(size = 0.5)+ 
  scale_colour_gradient(low="#DB5824", high="#1A5A95")+
  labs(title="LR04 Benthic Stack",                   
       x="Time (Ma)", 
       y=expression(δ^{18}*O~"(‰)"),                
       caption="Data from Lisiecki & Raymo (2005)")+ 
  scale_y_reverse()+                                 
  theme_classic()+
  theme(legend.position = "none")


# TO DO
# —————
# - change marks on x-axis to every million years
# - see if it is possible to alter where the blue changes to red on the gradient
# - move plot title to centre
# - add annotations to plot, e.g. MPT, box around MIS 7-9?
# - zoom in on MIS 7 to 9



# Last 500 ka -------------------------------------------------------------

lr04_500 <- subset(lr04, time<0.5) # subset last 500 ka
lr04_500$time <- lr04_500$time * 1000 # convert time from back from ma to ka

ggplot(data=lr04_500, 
       aes(x=time, y=d18o, colour=d18o))+ 
  geom_line(size = 0.8)+ 
  scale_colour_gradient(low="#DB5824", high="#1A5A95")+
  labs(title="LR04 Benthic Stack (Last 500 ka)",
       x="Age (ka)", 
       y=expression(δ^{18}*O~"(‰)"),                
       caption="Data from Lisiecki & Raymo (2005)")+ 
  scale_y_reverse()+                                 
  annotate("text", 
           x = c(5, 125, 205, 237, 327, 410), 
           y = c(3, 3, 3.3,3.3, 3, 3), 
           label = c("1", "5", "7 a-c", "7e", "9", "11"))+
  theme_classic(base_size=15)+
  theme(legend.position="none")



# MIS 7–9 (191–337 ka) ----------------------------------------------------

lr04_7to9 <- subset(lr04_500, time>130 & time<374) # subset MIS 7-9 

ggplot(data=lr04_7to9, 
       aes(x=time, y=d18o, colour=d18o))+ 
  geom_line(size = 0.8)+ 
  scale_colour_gradient(low="#DB5824", high="#1A5A95")+
  labs(title="LR04 Benthic Stack (MIS 7–9)",
       x="Age (ka)", 
       y=expression(δ^{18}*O~"(‰)"),                
       caption="Data from Lisiecki & Raymo (2005)")+ 
  scale_y_reverse()+                                 
  theme_classic()+
  theme(legend.position="none")
