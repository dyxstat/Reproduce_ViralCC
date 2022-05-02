virsorterfile = 'VIRSorter_global-phage-signal.csv'
vs.pred <- read.csv(virsorterfile,quote="",head=F)
vs.head <- read.table(virsorterfile,sep=",",quote="",head=T,comment="",skip=1,nrows=1)
colnames(vs.pred) <- colnames(vs.head)
colnames(vs.pred)[1] <- "vs.id"
vs.cats <- do.call(rbind,strsplit(x=as.character(vs.pred$vs.id[grep("category",vs.pred$vs.id)]),split=" - ",fixed=T))[,2]
vs.num <- grep("category",vs.pred$vs.id)
vs.pred$Category <- paste(c("",rep.int(vs.cats, c(vs.num[-1],nrow(vs.pred)) - vs.num)), vs.pred$Category)
vs.pred <- vs.pred[-grep("#",vs.pred$vs.id),]

vs.pred$node <- gsub(pattern="VIRSorter_",replacement="",x=vs.pred$vs.id)
vs.pred$node <- gsub(pattern="-circular",replacement="",x=vs.pred$node)
vs.pred$node <- gsub(pattern="cov_(\\d+)_",replacement="cov_\\1.",x=vs.pred$node,perl=F)

rownames(vs.pred) = seq(1 , 1393)

vs_phage = vs.pred[1:1338 , ]

phage_name = vs_phage$node

for(i in 1:1338)
{
  temp = paste0(strsplit(phage_name[i],split='_')[[1]][1] , '_' , strsplit(phage_name[i],split='_')[[1]][2])
  phage_name[i] = temp
}

group_name = rep('group0' , 1338)
phage = cbind(phage_name , group_name)

write.table(phage , file = 'viral.txt' ,  sep='\t', row.names = F , col.names = F , quote =FALSE)
