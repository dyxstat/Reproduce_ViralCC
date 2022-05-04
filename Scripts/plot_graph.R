####################write ggplot figure###############
library(ggplot2)
library(ggpubr)
library(ggforce)

theme_set(theme_bw()+theme(panel.spacing=grid::unit(0,"lines")))


##########柱状图对于不同方法和分类###########
Rank = rep(c('F-score' , 'ARI' , 'NMI' , 'Homogeneity') , each = 5)
Pipeline = rep(c('VAMB' , 'CoCoNet' , 'vRhyme' , 'bin3C' , 'ViralCC'),times = 4)
Number = c(0.198,0.485,0.366,0.404,0.795,
           0.111,0.471,0.302,0.274,0.787,
           0.724,0.742,0.782,0.817,0.929,
           0.570,0.723,0.687,0.691,0.921)

col = c('#8FBC94' , '#4FB0C6', "#4F86C6", "#527F76", '#CC9966')

df <- data.frame(Rank = Rank, Pipeline = Pipeline, Number = Number)
df$Pipeline = factor(df$Pipeline , levels=c('VAMB' , 'CoCoNet' , 'vRhyme' , 'bin3C' , 'ViralCC'))
df$Rank = factor(df$Rank , levels = c('F-score' , 'ARI' , 'NMI', 'Homogeneity'))


ggplot(data = df, mapping = aes(x = Rank, y = Number, fill = Pipeline)) + 
  geom_bar(stat = 'identity', position = 'dodge')+
  scale_fill_manual(values = col,limits= c('VAMB' , 'CoCoNet' , 'vRhyme' , 'bin3C' , 'ViralCC'))+
  coord_cartesian(ylim = c(0.05,0.975))+
  labs(x = "Clustering metrics", y = "Scores", title = "The mock human gut dataset")+
  theme(legend.position="bottom",
        legend.title=element_blank(),
        legend.text = element_text(size = 12),
        panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 14,face = "bold"),
        axis.title.y = element_text(size = 14,face = "bold"),
        title = element_text(size = 16,face = "bold"),
        plot.title = element_text(hjust = 0.5))

ggsave("fig2a.eps", width = 7 , height = 6 , device = cairo_ps)




Rank = rep(c('VAMB' , 'CoCoNet' , 'vRhyme' , 'bin3C' , 'ViralCC'),each = 3)
Pipeline = rep(c('Moderately complete' , 'Substantially complete' ,  'Near-complete'),times = 5)
Number = c(2,4,1,
           1,5,5, 
           6,1,0,
           1,0,5, 
           4,2,26)

col = c("#8FBC94","#77AAAD","#6E7783")

df <- data.frame(Rank = Rank, Pipeline = Pipeline, Number = Number)
df$Pipeline = factor(df$Pipeline , levels=c('Moderately complete' , 'Substantially complete' ,  'Near-complete'))
df$Rank = factor(df$Rank , levels = c('VAMB' , 'CoCoNet' , 'vRhyme' , 'bin3C' , 'ViralCC'))


ggplot(data = df, mapping = aes(x = Rank, y = Number, fill = Pipeline)) + 
  geom_bar(stat = 'identity', position = 'stack')+
  scale_fill_manual(values = col,limits= c('Moderately complete' , 'Substantially complete' ,  'Near-complete'))+
  labs(x = "Binning method", y = "Number of viral bins", title = "The mock human gut dataset")+
  theme(legend.position="bottom",
        legend.title=element_blank(),
        legend.text = element_text(size = 12),
        panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 14,face = "bold"),
        axis.title.y = element_text(size = 14,face = "bold"),
        title = element_text(size = 16,face = "bold"),
        plot.title = element_text(hjust = 0.5))

ggsave("fig2b.eps", width = 7, height = 6, device = cairo_ps)



viral_num = data.frame('number' = c(1, 4 , 1 , 1 , 13),
                         'method' = c('VAMB' , 'CoCoNet' , 'vRhyme' , 'bin3C' , 'ViralCC'))

viral_num$method = factor(viral_num$method , levels=c('VAMB' , 'CoCoNet' , 'vRhyme' , 'bin3C' , 'ViralCC'))



ggplot(data = viral_num, aes(x = method , y = number )) + 
  geom_bar(stat = "identity", position='dodge' , width = 0.9,fill = 'steelblue') +  
  labs(x = 'Binning method', y = 'Number of high-quality vMAGs within the co-host systems', title = "The mock human gut dataset") +
  theme(
        panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 14,face = "bold"),
        axis.title.y = element_text(size = 14,face = "bold"),
        title = element_text(size = 16,face = "bold"),
        plot.title = element_text(hjust = 0.5))

ggsave("fig2c.eps", width = 7, height = 6, device = cairo_ps)





##############human gut 2a############
Rank = rep(c('ViralCC' ,'bin3C' , 'vRhyme' , 'CoCoNet' , 'VAMB'),each = 5)
Completeness = rep(c( "≥ 50%", "≥ 60%", "≥ 70%", "≥ 80%" , "≥ 90%"),times = 5)
###Number needs to be 4*5 matrix##
Number = c(11 , 12 , 17  , 7 , 78,
           1 , 0 , 1 , 4 , 33,
           10, 11, 10, 6, 60,
           2, 1 , 3 , 2 , 25,
           10, 11, 14, 15, 69)

col = c("#023FA5" ,"#5465AB" ,"#7D87B9" ,"#A1A6C8" ,"#BEC1D4")[5:1]
df <- data.frame(Rank = Rank, Completeness = Completeness, Number = Number)
df$Completeness = factor(df$Completeness , levels=c("≥ 50%", "≥ 60%", "≥ 70%", "≥ 80%" , "≥ 90%"))
df$Rank = factor(df$Rank , levels = c('ViralCC' ,'bin3C' , 'vRhyme' , 'CoCoNet' , 'VAMB'))


ggplot(data = df, mapping = aes(x = Rank, y = Number, fill = Completeness)) + 
  geom_bar(stat = 'identity', position = 'stack')+
  scale_fill_manual(values = col , limits= c("≥ 50%", "≥ 60%", "≥ 70%", "≥ 80%" , "≥ 90%"))+
  labs(x = "Binning method", y = "Number of bins", 
       title = "CheckV results on the real human gut dataset")+
  coord_flip()+
  theme(legend.position="bottom",
        legend.title=element_text(size = 11),
        legend.text = element_text(size = 11),
        panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 13,face = "bold"),
        axis.title.y = element_text(size = 13,face = "bold"),
        title = element_text(size = 14,face = "bold"),
        plot.title = element_text(hjust = 0.5))

ggsave("fig3a.eps", width = 6.3, height = 5, device = cairo_ps)



##############cow fecal 2b############
Rank = rep(c('ViralCC' ,'bin3C' , 'vRhyme' , 'CoCoNet' , 'VAMB'),each = 5)
Completeness = rep(c( "≥ 50%", "≥ 60%", "≥ 70%", "≥ 80%" , "≥ 90%"),times = 5)
###Number needs to be 4*5 matrix##
Number = c(21 , 14 , 21  , 9 , 60,
           14 , 17 , 12 , 8 , 31,
           18, 14 , 16 , 14 , 36,
           3, 3 , 2 , 2 , 25,
           19,17,10,8,23)

col = c("#023FA5" ,"#5465AB" ,"#7D87B9" ,"#A1A6C8" ,"#BEC1D4")[5:1]
df <- data.frame(Rank = Rank, Completeness = Completeness, Number = Number)
df$Completeness = factor(df$Completeness , levels=c("≥ 50%", "≥ 60%", "≥ 70%", "≥ 80%" , "≥ 90%"))
df$Rank = factor(df$Rank , levels = c('ViralCC' ,'bin3C' , 'vRhyme' , 'CoCoNet' , 'VAMB'))


ggplot(data = df, mapping = aes(x = Rank, y = Number, fill = Completeness)) + 
  geom_bar(stat = 'identity', position = 'stack')+
  scale_fill_manual(values = col , limits= c("≥ 50%", "≥ 60%", "≥ 70%", "≥ 80%" , "≥ 90%"))+
  labs(x = "Binning method", y = "Number of bins", 
       title = "CheckV results on the real cow fecal dataset")+
  coord_flip()+
  theme(legend.position="bottom",
        legend.title=element_text(size = 11),
        legend.text = element_text(size = 11),
        panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 13,face = "bold"),
        axis.title.y = element_text(size = 13,face = "bold"),
        title = element_text(size = 14,face = "bold"),
        plot.title = element_text(hjust = 0.5))

ggsave("fig3b.eps", width = 6.3, height = 5, device = cairo_ps)


##############wastewater 2c############
Rank = rep(c('ViralCC' ,'bin3C' , 'vRhyme' , 'CoCoNet' , 'VAMB'),each = 5)
Completeness = rep(c( "≥ 50%", "≥ 60%", "≥ 70%", "≥ 80%" , "≥ 90%"),times = 5)
###Number needs to be 3*5 matrix##
Number = c(30 , 27 , 21  , 17 , 77,
           19, 20 , 11 , 11 , 28,
           14,16,14,15,32,
           2, 8 , 8 , 6 , 38,
           20,34,14,13,58)


col = c("#023FA5" ,"#5465AB" ,"#7D87B9" ,"#A1A6C8" ,"#BEC1D4")[5:1]
df <- data.frame(Rank = Rank, Completeness = Completeness, Number = Number)
df$Completeness = factor(df$Completeness , levels=c("≥ 50%", "≥ 60%", "≥ 70%", "≥ 80%" , "≥ 90%"))
df$Rank = factor(df$Rank , levels = c('ViralCC' ,'bin3C' , 'vRhyme' , 'CoCoNet' , 'VAMB'))


ggplot(data = df, mapping = aes(x = Rank, y = Number, fill = Completeness)) + 
  geom_bar(stat = 'identity', position = 'stack')+
  scale_fill_manual(values = col , limits= c("≥ 50%", "≥ 60%", "≥ 70%", "≥ 80%" , "≥ 90%"))+
  labs(x = "Binning method", y = "Number of bins", 
       title = "CheckV results on the real wastewater dataset")+
  coord_flip()+
  theme(legend.position="bottom",
        legend.title=element_text(size = 11),
        legend.text = element_text(size = 11),
        panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 13,face = "bold"),
        axis.title.y = element_text(size = 13,face = "bold"),
        title = element_text(size = 14,face = "bold"),
        plot.title = element_text(hjust = 0.5))

ggsave("fig3c.eps", width = 6.35, height = 5, device = cairo_ps)



########Fraction of host by different number of viruses#########

df<-data.frame(group=c('infected by one virus' , 'infected by two viruses', 'infected by three viruses'),
               value=c(25,35,45))
df$group = as.vector(df$group)

ggplot(df,aes(x="",y=value,fill=group))+
  geom_bar(stat="identity")+
  coord_polar("y",start=1) + 
  geom_text(aes(y=
                  c(0,cumsum(value)[-length(value)]),
                label=percent(value/100)),size=5)+
  theme_minimal()+
  theme(axis.title=element_blank(),
        axis.ticks=element_blank(),
        axis.text = element_blank(),
        legend.title = element_blank())+
  scale_fill_manual(values=c("darkgreen","orange","deepskyblue"))




##########Supplementary material###########
########Mock cow fecal dataset#######
Rank = rep(c('F-score' , 'ARI' , 'NMI' , 'Homogeneity') , each = 4)
Pipeline = rep(c( 'CoCoNet' , 'vRhyme', 'bin3C' , 'ViralCC'),times = 4)
Number = c(0.564, 0.763 , 0.936 , 0.936,
           0.455 ,0.719, 0.926 , 0.926,
           0.796 , 0.885 , 0.969 , 0.963,
           0.661 ,0.806, 0.940 , 1)

col = c('#4FB0C6', "#4F86C6", "#527F76", '#CC9966')

df <- data.frame(Rank = Rank, Pipeline = Pipeline, Number = Number)
df$Pipeline = factor(df$Pipeline , levels=c('CoCoNet' , 'vRhyme', 'bin3C' , 'ViralCC'))
df$Rank = factor(df$Rank , levels = c('F-score' , 'ARI' , 'NMI', 'Homogeneity'))


ggplot(data = df, mapping = aes(x = Rank, y = Number, fill = Pipeline)) + 
  geom_bar(stat = 'identity', position = 'dodge')+
  scale_fill_manual(values = col,limits= c('CoCoNet' , 'vRhyme', 'bin3C' , 'ViralCC'))+
  coord_cartesian(ylim = c(0.3,1))+
  labs(x = "Clustering metrics", y = "Scores", 
       title = "The mock cow fecal dataset")+
  theme(legend.position="bottom",
        legend.title=element_blank(),
        legend.text = element_text(size = 12),
        panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 14,face = "bold"),
        axis.title.y = element_text(size = 14,face = "bold"),
        title = element_text(size = 16,face = "bold"),
        plot.title = element_text(hjust = 0.5))

ggsave("sp1a.eps", width = 6, height = 5, device = cairo_ps)




Rank = rep(c('CoCoNet' , 'vRhyme', 'bin3C' , 'ViralCC'),each = 3)
Pipeline = rep(c('Moderately complete' , 'Substantially complete' ,  'Near-complete'),times = 4)
Number = c(1 , 1 , 3 , 
           3,2,2,
           1, 3 , 5 , 
           0 ,0 , 8 )

col = c("#8FBC94","#77AAAD","#6E7783")

df <- data.frame(Rank = Rank, Pipeline = Pipeline, Number = Number)
df$Pipeline = factor(df$Pipeline , levels=c('Moderately complete' , 'Substantially complete' ,  'Near-complete'))
df$Rank = factor(df$Rank , levels = c('CoCoNet' , 'vRhyme', 'bin3C' , 'ViralCC'))


ggplot(data = df, mapping = aes(x = Rank, y = Number, fill = Pipeline)) + 
  geom_bar(stat = 'identity', position = 'stack')+
  coord_cartesian(ylim = c(0 , 9))+
  scale_y_discrete(limits = c(0 , 3 , 6 , 9))+
  scale_fill_manual(values = col,limits= c('Moderately complete' , 'Substantially complete' ,  'Near-complete'))+
  labs(x = "Binning method", y = "Number of viral bins", title = "The mock cow fecal dataset")+
  theme(legend.position="bottom",
        legend.title=element_blank(),
        legend.text = element_text(size = 12),
        panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 14,face = "bold"),
        axis.title.y = element_text(size = 14,face = "bold"),
        title = element_text(size = 16,face = "bold"),
        plot.title = element_text(hjust = 0.5))

ggsave("sp1b.eps", width = 6, height = 5, device = cairo_ps)


##########Supplementary material###########
########Mock wastewater fecal#######
Rank = rep(c('F-score' , 'ARI' , 'NMI' , 'Homogeneity') , each = 4)
Pipeline = rep(c('CoCoNet' , 'vRhyme', 'bin3C' , 'ViralCC'),times = 4)
Number = c(0.667,0.657,0.858,0.903,
           0.602 ,0.596,0.828,0.891,
           0.806 ,0.843, 0.898,0.937,
           0.687 ,0.746, 0.816,0.881)

col = c('#4FB0C6', "#4F86C6", "#527F76", '#CC9966')

df <- data.frame(Rank = Rank, Pipeline = Pipeline, Number = Number)
df$Pipeline = factor(df$Pipeline , levels=c('CoCoNet' , 'vRhyme', 'bin3C' , 'ViralCC'))
df$Rank = factor(df$Rank , levels = c('F-score' , 'ARI' , 'NMI', 'Homogeneity'))


ggplot(data = df, mapping = aes(x = Rank, y = Number, fill = Pipeline)) + 
  geom_bar(stat = 'identity', position = 'dodge')+
  scale_fill_manual(values = col,limits= c('CoCoNet' , 'vRhyme', 'bin3C' , 'ViralCC'))+
  coord_cartesian(ylim = c(0.1,0.97))+
  labs(x = "Clustering metrics", y = "Scores", 
       title = "The mock wastewater dataset")+
  theme(legend.position="bottom",
        legend.title=element_blank(),
        legend.text = element_text(size = 12),
        panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 14,face = "bold"),
        axis.title.y = element_text(size = 14,face = "bold"),
        title = element_text(size = 16,face = "bold"),
        plot.title = element_text(hjust = 0.5))

ggsave("sp1c.eps", width = 6, height = 5, device = cairo_ps)




Rank = rep(c('CoCoNet' , 'vRhyme', 'bin3C' , 'ViralCC'),each = 3)
Pipeline = rep(c('Moderately complete' , 'Substantially complete' ,  'Near-complete'),times = 4)
Number = c( 5 , 3 , 1 , 
            1,2,2,
           1, 3 , 1 , 
           1 ,3 , 12 )

col = c("#8FBC94","#77AAAD","#6E7783")

df <- data.frame(Rank = Rank, Pipeline = Pipeline, Number = Number)
df$Pipeline = factor(df$Pipeline , levels=c('Moderately complete' , 'Substantially complete' ,  'Near-complete'))
df$Rank = factor(df$Rank , levels = c('CoCoNet' , 'vRhyme', 'bin3C' , 'ViralCC'))


ggplot(data = df, mapping = aes(x = Rank, y = Number, fill = Pipeline)) + 
  geom_bar(stat = 'identity', position = 'stack')+
  scale_fill_manual(values = col,limits= c('Moderately complete' , 'Substantially complete' ,  'Near-complete'))+
  labs(x = "Binning method", y = "Number of viral bins", title = "The mock wastewater dataset")+
  theme(legend.position="bottom",
        legend.title=element_blank(),
        legend.text = element_text(size = 12),
        panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        axis.title.x = element_text(size = 14,face = "bold"),
        axis.title.y = element_text(size = 14,face = "bold"),
        title = element_text(size = 16,face = "bold"),
        plot.title = element_text(hjust = 0.5))

ggsave("sp1d.eps", width = 6, height = 5, device = cairo_ps)


##########CheckM results#############
Rank = rep(c('MetaBAT2' , 'CoCoNet' , 'bin3C' , 'ViralCC'),each = 3)
Pipeline = rep(c('Moderately complete' , 'Substantially complete' ,  'Near-complete'),times = 4)
Number = c(3 , 4 , 4  , 
           5 , 3 , 1 , 
           1, 3 , 1 , 
           2 ,2 , 12 )

col = c("#8FBC94","#77AAAD","#6E7783")

df <- data.frame(Rank = Rank, Pipeline = Pipeline, Number = Number)
df$Pipeline = factor(df$Pipeline , levels=c('Moderately complete' , 'Substantially complete' ,  'Near-complete'))
df$Rank = factor(df$Rank , levels = c('MetaBAT2' , 'CoCoNet' , 'bin3C' , 'ViralCC'))


ggplot(data = df, mapping = aes(x = Rank, y = Number, fill = Pipeline)) + 
  geom_bar(stat = 'identity', position = 'stack')+
  scale_fill_manual(values = col,limits= c('Moderately complete' , 'Substantially complete' ,  'Near-complete'))+
  labs(x = "Binning method", y = "Number of bins", title = "Mock wastewater dataset")+
  theme(legend.position="top",
        legend.title=element_blank(),
        legend.text = element_text(size = 11),
        panel.grid.major = element_blank(),   #不显示网格线
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(size = 11),
        axis.text.y = element_text(size = 11),
        axis.title.x = element_text(size = 14,face = "bold"),
        axis.title.y = element_text(size = 14,face = "bold"),
        title = element_text(size = 14,face = "bold"),
        plot.title = element_text(hjust = 0.5))





#######Compute the length of viral contigs########
contig_info = read.csv('contig_viral_info_ww.csv' , sep = ',' , header = F)
min(contig_info[,3])
max(contig_info[,3])



#######Chi-square testing############
tableR = matrix(c(72,96,264,36,38,90,21,24,49,38,42,80),nrow=3)
chisq.test(tableR,correct = F)









