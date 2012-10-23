trim = function(object){
    s <- sub("^[\t\n\f\r ]*", "", as.character(object))
    s <- sub("[\t\n\f\r ]*$", "", s)
    s
}

infile = "~/bioc/allR.R"

t = readLines(infile)

regexp = "[a-zA-Z.][a-zA-Z0-9._]* *\\("
matches = gregexpr(regexp, t)

words = list()

for(i in 1:length(matches)){
	m = matches[[i]]
	if(m[1] == -1)
		next
	
	for(j in 1:length(m)){
		tryCatch({
			word = substr(t[i], m[j], m[j]+attr(m, "match.length")[j]-2)
			word = trim(word)
		
			is.function.name = tryCatch(eval(parse(text=paste("is.function(", word, ")"))),
				error=function(e) FALSE)
		
			if(is.function.name){		
				if(!(word %in% names(words)))
					words[[word]] = 1
				else
					words[[word]] = words[[word]] + 1
			}
		}, error = function(e){})
	}
}

out = data.frame("fun"=names(words), "freq"=as.numeric(words))
out = out[order(out$freq, decreasing=T),]

write.table(out, "functionCloud.txt", row.names=F, col.names=T, quote=F, sep="\t")
out[,2] = round(log2(out[,2]), 3)
write.table(out, "functionCloud-log2.txt", row.names=F, col.names=T, quote=F, sep="\t")

