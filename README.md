A shiny app for exploring word embedding models



![Alt text](screenshot.png?raw=true "Screenshot")



## Setup
Requires a word embeddings file, from word2Vec. Put it in the home directory, and name it `word_embeddings.bin`

Also requires:
```
library(devtools)
install_github('bmschmidt/wordVectors')
```

## Run app:

From R:

```
shiny::runApp()
```

From the command line:

```
Rscript runapp.R
```
