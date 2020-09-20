# Set up ------------------------------------------------------------------

rm(list=ls())
library(ggplot2)



# Read and check data -----------------------------------------------------

lr04 <- read.delim("./data/lr04.txt")
str(lr04)
head(lr04)



# Basic plot --------------------------------------------------------------

ggplot(data=lr04, aes(x=time, y=d18o))+               # set up plot
  geom_line(colour = "#00AFBB", size = 0.5)+          # plot line
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
  geom_line(colour="#00AFBB", size=0.5)+
  labs(title="LR04 Benthic Stack",
       x="Time (Ma)", 
       y=expression(δ^{18}*O~"(‰)"),                 
       caption="Data from Lisiecki & Raymo (2005)")+ 
  scale_y_reverse()+ 
  scale_x_continuous(breaks=seq(0, 6, by=1))+    # set tick frequency
  theme_classic(base_size=15)

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
  scale_x_continuous(breaks = seq(0, 6, by = 1))+
  theme_classic(base_size=15)+
  theme(legend.position = "none")



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
  annotate("text", 
           x=c(160, 200, 225, 237, 260, 283, 297, 310, 320, 327, 360), 
           y=c(4.9, 3.4, 4.5, 3.3, 4.7, 3.75, 4.4, 3.6, 3.95, 3.1, 4.9), 
           label = c("6", "7 a-c", "7d", "7e", "8", "9a", "9b", "9c?", "9d?", 
                     "9e", "10"))+
  scale_y_reverse()+    
  scale_x_continuous(breaks=seq(120, 380, by=20))+
  theme_classic(base_size=15)+
  theme(legend.position="none")



# Plot vertically ---------------------------------------------------------

# These types of plots are often displayed vertically so I'll have a go at 
# flipping them around. The following block of code needs to be added to the 
# plots:
#   scale_y_reverse(position="right")+  
#   scale_x_reverse()+
#   coord_flip()+ 

# All data
ggplot(data=lr04, aes(x=time, y=d18o))+
  geom_line(colour="#00AFBB", size=0.5)+
  labs(title="LR04 Benthic Stack",
       x="Time (Ma)", 
       y=expression(δ^{18}*O~"(‰)"),                 
       caption="Data from Lisiecki & Raymo (2005)")+ 
  scale_y_reverse(position="right")+  
  scale_x_reverse(breaks=seq(0, 6, by=1))+
  coord_flip()+  
  theme_classic(base_size=15)

# Last 500 ka
ggplot(data=lr04_500, 
       aes(x=time, y=d18o, colour=d18o))+ 
  geom_line(size = 0.8)+ 
  scale_colour_gradient(low="#DB5824", high="#1A5A95")+
  labs(title="LR04 Benthic Stack (Last 500 ka)",
       x="Age (ka)", 
       y=expression(δ^{18}*O~"(‰)"),                
       caption="Data from Lisiecki & Raymo (2005)")+
  annotate("text", 
           x = c(5, 125, 205, 237, 327, 410), 
           y = c(3, 3, 3.3,3.3, 3, 3), 
           label = c("1", "5", "7 a-c", "7e", "9", "11"))+
  scale_y_reverse(position="right")+  
  scale_x_reverse()+
  coord_flip()+  
  theme_classic(base_size=15)+
  theme(legend.position="none")

# MIS 7-9
ggplot(data=lr04_7to9, aes(x=time, y=d18o, colour=d18o))+ 
  geom_line(size = 0.8)+ 
  scale_colour_gradient(low="#DB5824", high="#1A5A95")+
  labs(title="LR04 Benthic Stack (MIS 7–9)",
       x="Age (ka)", 
       y=expression(δ^{18}*O~"(‰)"),                
       caption="Data from Lisiecki & Raymo (2005)")+ 
  annotate("text", 
           x = c(160, 200, 225, 237, 260, 283, 297, 310, 320, 327, 360), 
           y = c(4.9, 3.4, 4.5, 3.3, 4.7, 3.75, 4.4, 3.6, 3.95, 3.1, 4.9), 
           label = c("6", "7 a-c", "7d", "7e", "8", "9a", "9b", "9c?", "9d?", 
                     "9e", "10"))+
  scale_y_reverse(position="right")+  
  scale_x_reverse(breaks=seq(120, 380, by=20))+
  coord_flip()+                             
  theme_classic(base_size=15)+
  theme(legend.position="none")



# To Do -------------------------------------------------------------------

# - see if it is possible to alter where the blue changes to red on the gradient
# - move plot title to centre
# - investigate how to export plots to pdf with special characters preserved