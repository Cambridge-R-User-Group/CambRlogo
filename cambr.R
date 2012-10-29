## original code by Robert Stojnic
## modified by Laurent Gatto

library(wordcloud)
library(RColorBrewer)

t <- read.delim("functionCloud-sqrt.txt", as.is = TRUE)
t$freq = round(t$freq)
## add CambR
t <- rbind(list("CambR", 300), t)
## decrease stop
t[t$fun == "stop", "freq"] <- 60 ## was 123

## color scheme
pal <- brewer.pal(9,"Blues")[5:9]

pdf("./figs/CambR-logo.pdf")
wordcloud(t$fun, t$freq, c(6,.1), max.words = 200, random.order = FALSE, colors = pal)
dev.off()

jpeg("./figs/CambR-logo.jpg")
wordcloud(t$fun, t$freq, c(6,.1), max.words = 200, random.order = FALSE, colors = pal)
dev.off()

svg("./figs/CambR-logo.svg")
wordcloud(t$fun, t$freq, c(6,.1), max.words = 200, random.order = FALSE, colors = pal)
dev.off()

