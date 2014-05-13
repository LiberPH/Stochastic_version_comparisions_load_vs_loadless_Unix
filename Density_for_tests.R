#!/usr/bin/env Rscript

# ...
library(sm)
library(MASS)
library(lattice)
library(latticeExtra)
library(ggplot2)


#argv <- commandArgs(T);S	
#a <- getwd()
#foo <- argv[1]

foo <- "MM"
coso <- paste(foo,".+.gdat",sep="")

filenames <- list.files(pattern=coso)
controls <- list.files(pattern="control.+gdat")


ldf <- lapply(filenames, read.table)
time <- lapply(ldf[1],"[",1)
#samlpe <- time <- lapply(ldf[1],"[",2)
time <- matrix(unlist(time), ncol = 1)
ttime <- t(time)
ldf <- lapply(ldf,"[",2)

ldfcont <- lapply(controls, read.table)
ldfcont <- lapply(ldfcont,"[",2)


cosa <- do.call(cbind, ldf)
control <- do.call(cbind, ldfcont)

tcosa <- t(cosa)
tcontrol <- t(control)

#things <- cbind(time,cosa)
things <- (cosa)
things <- as.matrix(things)

control <- as.matrix(control)

#controles <- cbind(ttime,control)
controles <- control
controles <- as.matrix(control)

ttime <- as.vector(ttime)
length(ttime)
number <- 1:94
length(number)
as.vector(number)
dim(t(things))


diamonds_small <-as.vector(things[1000,])
diamonds_big <- as.vector(controles[1000,])
pdf('density_500_e-9_e-11.pdf')
d <- density(diamonds_small)
plot(d, main="Concentration density at time 500 with kon e-9 koff e-11")
polygon(d, col=rgb(0, 0, 1,0.5), border="beige")
dc <- density(diamonds_big)
lines (density(diamonds_big))
polygon(dc, col=rgb(1, 0, 0,0.5), border="beige")
dev.off()




retro.hist <- (as.matrix(diamonds_small))
control.hist <- (as.matrix(diamonds_big))
dat <- data.frame(molecules=c(retro.hist,control.hist),lines=rep(c("retro","control"),each=1001))

#MYdata.melt <- melt(dat)
#ggplot(MYdata.melt, aes(x=value, color=variable)) + geom_density()


#Plot.
pdf('density_two_1000_e-9_e-11_V2.pdf')
ggplot(dat, aes(x = molecules, fill = lines)) + geom_density(alpha = 0.5) + opts(title = expression("Concentration density at time 1000 with kon e-9 koff e-11"))
dev.off()
