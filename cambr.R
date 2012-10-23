## original code by Robert Stojnic
## modified by Laurent Gatto

library(wordcloud)
library(RColorBrewer)

t = read.delim("functionCloud-sqrt.txt", as.is=T)
t$freq = round(t$freq)
## add CambR
t = rbind(list("CambR", 300), t)
## decrease stop
t[t$fun == "stop", "freq"] <- 60 ## was 123

## color scheme
pal = brewer.pal(9,"Blues")
pal = pal[-(1:4)]


pdf("CambR-logo.pdf")
wordcloud(t$fun, t$freq, c(6,.1), max.words = 200, random.order = FALSE, colors = pal)
dev.off()

jpeg("CambR-logo.jpg")
wordcloud(t$fun, t$freq, c(6,.1), max.words = 200, random.order = FALSE, colors = pal)
dev.off()

svg("CambR-logo.svg")
wordcloud(t$fun, t$freq, c(6,.1), max.words = 200, random.order = FALSE, colors = pal)
dev.off()

