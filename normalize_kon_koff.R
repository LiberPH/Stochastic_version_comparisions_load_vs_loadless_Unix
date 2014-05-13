#!/usr/bin/env Rscript

# ...

argv <- commandArgs(T);

# error checking...
a <- matrix(0,ncol=1000,nrow=1)
x <- read.table(argv[1],sep = "");


x <- x[,2];
#x
y <- read.table(argv[2],sep = "");
y <- y[,2];
diff <- dist(rbind(x, y), method = "canberra")  #Calculando distancia de canberra entre dos dinámicas

for(i in 1:1000){
random <-sample(x)
a[,i] <- dist(rbind(x,random), method="canberra")
}
m <- mean(a)

result <- diff/m

sink(argv[3])
cat(result)
sink()

