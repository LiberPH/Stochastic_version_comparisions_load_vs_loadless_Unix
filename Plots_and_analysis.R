#!/usr/bin/env Rscript

# ...
library(sm)
library(MASS)
argv <- commandArgs(T);
a <- getwd()
foo <- argv[1]
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

#controles <- cbind(ttime,control)
controles <- control
controles <- as.matrix(control)

pdf('retro_ensamble.pdf')
matplot(things, type = "l",ylab = "[Aa]",xlab="time")
dev.off()
pdf('control_ensamble.pdf')
matplot(controles, type= "l")
dev.off()
 