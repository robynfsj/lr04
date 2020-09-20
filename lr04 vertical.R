#### Clear the environment ####
rm(list=ls())



#### Load, explore and plot data ####

# read in lr04 dataframe
lr04 <- read.delim("/Users/robyn/R/Time Series in GGPlot/lr04.txt")

# browse the dataframe
str(lr04)
head(lr04)

# load ggplot2
library(ggplot2)

# build the plot
ggplot(data=lr04, aes(x=time, y=d18o))+
  geom_line(colour = "#00AFBB", size = 0.3)+
  labs(title="LR04 Benthic Stack", 
       x="Time (ka)", 
       y=expression(δ^{18}*O~"(‰)"),
       caption="Data from Lisiecki & Raymo (2005)")+
       theme_classic()



#### Time is plotted in thousands of years but I would prefer millions of years! ####

# convert time from ka to ma
lr04$time <- lr04$time/1000

# plot the graph with time in millions of years
ggplot(data=lr04, aes(x=time, y=d18o))+              # set up plot
  geom_line(colour = "#00AFBB", size = 0.3)+         # plot the line
  labs(title="LR04 Benthic Stack",                   # plot the labels
       x="Time (Ma)", 
       y=expression(δ^{18}*O~"(‰)"),                 # search online to find how to insert symbols and superscript
       caption="Data from Lisiecki & Raymo (2005)")+ # plots caption in lower right
  scale_y_reverse()+                                 # reverse scale on y-axis
  scale_x_reverse()+
  theme_classic()                                    # use the classic theme (remove grey background)
     

  
#### Line colour—gradient ####

ggplot(data=lr04, aes(x=time, y=d18o, colour=d18o))+ 
  geom_line(size = 0.5)+ 
  scale_colour_gradient(low="#DB5824", high="#1A5A95")+
  labs(title="LR04 Benthic Stack",                   
       x="Time (Ma)", 
       y=expression(δ^{18}*O~"(‰)"),                
       caption="Data from Lisiecki & Raymo (2005)")+ 
  scale_y_reverse()+                                 
  scale_x_reverse()+
  theme_classic()+
  theme(legend.position = "none")



# things I want to do:
# - change marks on x-axis to every million years
# - see if it is possible to alter where the blue changes to red on the gradient
# - move plot title to centre
# - add annotations to plot, e.g. MPT, box around MIS 7-9?
# - zoom in on MIS 7 to 9


# subset last 500 ka
lr042 <- subset(lr04, time<0.5)

# convert time from back from ma to ka
lr042$time <- lr042$time * 1000

ggplot(data=lr042, aes(x=time, y=d18o, colour=d18o))+ 
  geom_line(size = 0.8)+ 
  scale_colour_gradient(low="#DB5824", high="#1A5A95")+
  labs(x="Age (ka)", 
       y=expression(δ^{18}*O~"(‰)"),                
       caption="Data from Lisiecki & Raymo (2005)")+ 
  scale_y_reverse(position = "right")+  
  scale_x_reverse()+
  coord_flip()+
  annotate("text", x = c(5, 125, 220, 327, 410), y = c(3, 3, 3.2, 3, 3), label = c("1", "5", "7", "9", "11"))+
  theme_classic(base_size = 15)+
  theme(legend.position = "none")

# subset MIS 7-9 (191-337 ka)

lr043 <- subset(lr042, time>186 & time<250)

ggplot(data=lr043, aes(x=time, y=d18o, colour=d18o))+ 
  geom_line(size = 0.8)+ 
  scale_colour_gradient(low="#DB5824", high="#1A5A95")+
  labs(x="Age (ka)", 
       y=expression(δ^{18}*O~"(‰)"),                
       caption="Data from Lisiecki & Raymo (2005)")+ 
  scale_y_reverse(position = "right", scale=)+
  scale_x_reverse()+
  coord_flip()+
  theme_classic(base_size = 15)+
  theme(legend.position = "none")







