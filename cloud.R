trim <- function(object){
    s <- sub("^[\t\n\f\r ]*", "", as.character(object))
    s <- sub("[\t\n\f\r ]*$", "", s)
    s
}

t <- readLines("allR.R")

regexp <- "[a-zA-Z.][a-zA-Z0-9._]* *\\("
matches <- gregexpr(regexp, t)
k <- which(sapply(matches, function(x) x[[1]] != -1))
  
words <- list()
for(i in k) {
  m <- matches[[i]]
  for (j in 1:length(m)) {
    tryCatch({
      word <- substr(t[i], m[j], m[j]+attr(m, "match.length")[j]-2)
      word <- trim(word)      
      is.function.name <-
        tryCatch(eval(parse(text=paste("is.function(", word, ")"))),
                 error = function(e) FALSE)
      if (is.function.name) {		
        if (!(word %in% names(words))) {
          words[[word]] <- 1
        } else {
          words[[word]] <- words[[word]] + 1
        }
      }
    }, error = function(e){ })
  }
}

out <- data.frame("fun" = names(words), "freq" = as.numeric(words))
log2out <- sqrtout <- out <- out[order(out$freq, decreasing = TRUE),]

write.table(out, "functionCloud.txt",
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

log2out[,2] <- round(log2(out[,2]), 3)
write.table(log2out, "functionCloud-log2.txt",
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

sqrtout[,2] <- round(sqrt(out[,2]), 2)
write.table(sqrtout, "functionCloud-sqrt.txt",
            row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

