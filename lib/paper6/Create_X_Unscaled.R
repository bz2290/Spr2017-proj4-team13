#######################
###The Create_X function aims to obtained the tfidf matrix for a given file.
##Input: File name (You should first load all files in to the computer)
##Output: tfidf matrix for the selected file
###########################
Create_X2<-function(Filename){
  ##Get DTM for Coauthor:
  CoAu <- itoken(Filename$Coauthor,
                 preprocessor = tolower,
                 tokenizer = word_tokenizer,
                 ids = Filename$PaperID,
                 # turn off progressbar because it won't look nice in rmd
                 progressbar = FALSE)
  
  vo_CoAu <- create_vocabulary(CoAu, stopwords = 
                                 c("a", "an", "the", "in", "on", "at", "of", "about", "for"))
  vector_CoAu <- vocab_vectorizer(vo_CoAu)
  dtm_CoAu <- create_dtm(CoAu , vector_CoAu)
  
  ##Get DTM for Title:
  Pap <- itoken(Filename$Paper,
                preprocessor = tolower,
                tokenizer = word_tokenizer,
                ids = Filename$PaperID,
                # turn off progressbar because it won't look nice in rmd
                progressbar = FALSE)
  
  vo_Pap<- create_vocabulary(Pap, stopwords = 
                               c("a", "an", "the", "in", "on", "at", "of", "about", "for"))
  
  vector_Pap <- vocab_vectorizer(vo_Pap)
  dtm_Pap <- create_dtm(Pap,vector_Pap)
  
  
  ##Get DTM for Journal:
  Jour <- itoken(Filename$Journal,
                 preprocessor = tolower,
                 tokenizer = word_tokenizer,
                 ids = Filename$PaperID,
                 # turn off progressbar because it won't look nice in rmd
                 progressbar = FALSE)
  vo_Jour<- create_vocabulary(Jour, stopwords = 
                                c("a", "an", "the", "in", "on", "at", "of", "about", "for"))
  
  vector_Jour <- vocab_vectorizer(vo_Jour)
  dtm_Jour <- create_dtm(Jour,vector_Jour)
  
  ##Get tfidf matrixes respectively
  tfidf <- TfIdf$new()
  dtm_CoAu_tfidf <- fit_transform(dtm_CoAu, tfidf)
  dtm_Pap_tfidf<-fit_transform(dtm_Pap, tfidf)
  dtm_Jour_tfidf<-fit_transform(dtm_Jour, tfidf)
  #dim(dtm_CoAu_tfidf)
  #dim(dtm_Pap_tfidf)
  #dim(dtm_Jour_tfidf)
  
  ##Get tfidf matrix by combining all features:
  tfid_matrix<-as.matrix(cbind(dtm_CoAu_tfidf,dtm_Pap_tfidf,dtm_Jour_tfidf))
  return(tfid_matrix)
}

