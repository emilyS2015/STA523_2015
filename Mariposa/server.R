list.of.packages <- c("parallel","truncnorm","ggplot2","gridExtra","twitteR","stringr","httr","RCurl",
                      "rjson","tm","wordcloud","foreach","googleVis","shiny","base64enc")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

lapply(list.of.packages, suppressPackageStartupMessages(library),character.only = TRUE)

# options(httr_oauth_cache=T)
# api_key <- "hftNGPFqzf9GMnHLMQVnNV7Vz"
#
# api_secret <- "HjTPQByqFDdriKKEixRbm4UNn2golHR5qGPbrPogRDm0tQkFua"
#
# access_token <- "296897722-PllUrWEvYediPUkYtJf8dwr2vmZe0p5O0mWP46Cc"
#
# access_token_secret <- "1NySI44qSZW0Ie6SEesd1T28NOun3NiOPyhe3QxLaNvuY"
#
# setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
api_key <- "a1CN89yFTk4fSaIanFpMQnfK8"

api_secret <- "HxVBDJNdIW1KkZnPiqj9qw7Vn25ILlYqywcHCgHJt1JLvRhaWW"

access_token <- "296897722-b3mIQzlLEHTiaO5zgxr521DPWhZXLvQ5JlKUaMWh"

access_token_secret <- "8Ldb6k3uF9b7UkmuzT7TrCvmN6HW1L8bHJknkHzIrvv8u"

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

#data frame for drop down menu and data visualization
geoinfo_state = data.frame("State" = c("Alabama", "Alaska", "Arizona", "Arkansas",
                                       "California", "Colorado", "Connecticut",
                                       "Delaware", "Florida", "Georgia", "Hawaii",
                                       "Idaho", "Illinois", "Indiana", "Iowa", "Kansas",
                                       "Kentucky", "Louisiana", "Maine", "Maryland",
                                       "Massachusetts", "Michigan", "Minnesota",
                                       "Mississippi", "Missouri", "Montana", "Nebraska",
                                       "Nevada", "New Hampshire", "New Jersey",
                                       "New Mexico", "New York", "North Carolina",
                                       "North Dakota", "Ohio", "Oklahoma", "Oregon",
                                       "Pennsylvania", "Rhode Island", "South Carolina",
                                       "South Dakota", "Tennessee", "Texas", "Utah",
                                       "Vermont", "Virginia", "Washington", "West Virginia",
                                       "Wisconsin", "Wyoming"),
                           "Geo" = c("32.31823,-86.9023,550mi","64.20084,-149.4937,550mi",
                                     "34.04893,-111.0937,550mi","35.20105,-91.83183,550mi",
                                     "36.77826,-119.4179,550mi","39.55005,-105.7821,550mi",
                                     "41.60322,-73.08775,550mi","38.91083,-75.52767,550mi",
                                     "27.66483,-81.51575,550mi","32.16562,-82.90008,550mi",
                                     "19.89677,-155.5828,550mi","44.0682,-114.742,550mi",
                                     "40.63312,-89.39853,550mi","40.26719,-86.1349,550mi",
                                     "41.878,-93.0977,550mi","39.0119,-98.48425,550mi",
                                     "37.83933,-84.27002,550mi","30.9843,-91.96233,550mi",
                                     "45.25378,-69.44547,550mi","39.04575,-76.64127,550mi",
                                     "42.40721,-71.38244,550mi","44.31484,-85.60236,550mi",
                                     "46.72955,-94.6859,550mi","32.35467,-89.39853,550mi",
                                     "37.96425,-91.83183,550mi","46.87968,-110.3626,550mi",
                                     "41.49254,-99.90181,550mi","38.80261,-116.4194,550mi",
                                     "43.19385,-71.5724,550mi","40.05832,-74.40566,550mi",
                                     "34.51994,-105.8701,550mi","40.71278,-74.00594,550mi",
                                     "35.75957,-79.0193,550mi","47.55149,-101.002,550mi",
                                     "40.41729,-82.90712,550mi","35.46756,-97.51643,550mi",
                                     "43.80413,-120.5542,550mi","41.20332,-77.19452,550mi",
                                     "41.58009,-71.47743,550mi","33.83608,-81.16372,550mi",
                                     "43.96951,-99.90181,550mi","35.51749,-86.58045,550mi",
                                     "31.9686,-99.90181,550mi","39.32098,-111.0937,550mi",
                                     "44.5588,-72.57784,550mi","37.43157,-78.65689,550mi",
                                     "38.90719,-77.03687,550mi","38.59763,-80.4549,550mi",
                                     "43.78444,-88.78787,550mi","43.07597,-107.2903,550mi"),
                           "StateAbb" = c("AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID",
                                       "IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS",
                                       "MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK",
                                       "OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV",
                                       "WI","WY"),
                           "StatePop" = c(4822023,731449,6553255,2949131,38041430,5187582,3590347,
                                          917092,19317568,9919945,1392313,1595728,12875255,6537334,
                                          3078186,2885905,4380415,4601893,1329192,5884563,6646144,
                                          9883360,5379139,2984926,6021988,1005141,1855525,2758931,
                                          1320718,8864590,2085538,19570261,9752073,699628,11544225,
                                          3814820,3899353,12763536,1050292,4723723,833354,6456243,
                                          26059203,2855287,626011,8185867,6897012,1855413,5726398,
                                          576412),
                #1 - Democratic, 2 - Republican
                           "Party_lab" = c(2,2,2,2,1,1,1,1,1,2,1,2,1,2,1,2,2,2,1,1,1,1,1,2,2,2,2,1,1,1,
                                       1,1,2,2,1,2,1,1,1,2,2,2,2,2,1,1,1,2,1,2),
                           stringsAsFactors = F)
code <- c(Democrat=1, Republican=2)
geoinfo_state$Party <- names(code)[match(geoinfo_state$Party_lab, code)]


locs <- availableTrendLocations()
usid <- locs[which(locs$country == "United States"), c(1,3)]
rownames(usid) = NULL
colnames(usid) = c("City", "woeid")

shinyServer(
  function(input, output, session) {
    observe(
      {
    x <- input$Keywd

        # This will change the value of input$Keywd, based on x
        updateTextInput(session, "Keywd", value =  x)

      }
     )
###########################################################################################
##########################For the first Tab in the main panel##############################
###########################################################################################

     #State Top keywords
    state_topKey = reactive(
      {
#First write a function for text cleaning
  clean.text <- function(some_txt)
        {
          some_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", some_txt)
          some_txt = gsub("@\\w+", "", some_txt)
          some_txt = gsub("[[:punct:]]", "", some_txt)
          some_txt = gsub("[[:digit:]]", "", some_txt)
          some_txt = gsub("http\\w+", "", some_txt)
          some_txt = gsub("[ \t]{2,}", "", some_txt)
          some_txt = gsub("^\\s+|\\s+$", "", some_txt)
          some_txt = gsub("amp", "", some_txt)
    # define "tolower error handling" function
          try.tolower = function(x)
          {
            y = NA
            try_error = tryCatch(tolower(x), error=function(e) e)
            if (!inherits(try_error, "error"))
              y = tolower(x)
            return(y)
          }

          some_txt = sapply(some_txt, try.tolower)
          some_txt = some_txt[some_txt != ""]
          names(some_txt) = NULL
          return(some_txt)
        }


statePick_Geo = geoinfo_state[which(geoinfo_state$State==input$State),2]
        print("Getting tweets...")
        keyword = input$Keywd
        # get some tweets
        tweets = searchTwitter(keyword, input$n_tweets, lang="en",geocode = paste(statePick_Geo) )
        # get text
        tweet_txt = sapply(tweets, function(x) x$getText())

        # clean text
        tweet_clean = clean.text(tweet_txt)
        tweet_num = length(tweet_clean)
        # data frame (text, sentiment)
        tweet_df = data.frame(text=tweet_clean, sentiment=rep("", tweet_num),stringsAsFactors=FALSE)

#   count.docs = removeWords(tweet_df$text, stopwords("german"))
#   count.docs = removeWords(tweet_df$text, stopwords("english"))

        all_text <- paste(tweet_df$text, collapse = " ")
        corpus <- Corpus(VectorSource(all_text))
        #remove punctuation
        corpus <- tm_map(corpus, removePunctuation)
        #remove numbers
        corpus <- tm_map(corpus, removeNumbers)
        #remove redundant white space
        corpus <- tm_map(corpus, stripWhitespace)
        #remove stopwords in English
        corpus <- tm_map(corpus, removeWords,stopwords("en"))
        dtm <- as.matrix(DocumentTermMatrix(corpus))
        freq <- sort(colSums(dtm),decreasing = TRUE)
        freq <- as.data.frame(freq)
        TopN = head(freq,input$n_topKey_State)
        TopN$word = row.names(TopN)
        colnames(TopN)[2] = input$State
        colnames(TopN)[1] = "Rank"
        TopN[1] = seq.int(nrow(TopN))
        TopN
      })


########################################################################################
#######################For the second Tab in the main panel#############################
########################################################################################
    overall = reactive(
      {

        getSentiment <- function (text, key){

          text <- URLencode(text);

          #save all the spaces, then get rid of the weird characters that break the API, then convert back the URL-encoded spaces.
          text <- str_replace_all(text, "%20", " ");
          text <- str_replace_all(text, "%\\d\\d", "");
          text <- str_replace_all(text, " ", "%20");


          if (str_length(text) > 360){
            text <- substr(text, 0, 359);
          }
          ###############

          data <- getURL(paste("http://api.datumbox.com/1.0/TwitterSentimentAnalysis.json?api_key=", key, "&text=",text, sep=""))

          js <- fromJSON(data);

          # get mood probability
          sentiment = js$output$result

          ################


          return(list(sentiment=sentiment))
        }

        clean.text <- function(some_txt)
        {
          some_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", some_txt)
          some_txt = gsub("@\\w+", "", some_txt)
          some_txt = gsub("[[:punct:]]", "", some_txt)
          some_txt = gsub("[[:digit:]]", "", some_txt)
          some_txt = gsub("http\\w+", "", some_txt)
          some_txt = gsub("[ \t]{2,}", "", some_txt)
          some_txt = gsub("^\\s+|\\s+$", "", some_txt)
          some_txt = gsub("amp", "", some_txt)
          # define "tolower error handling" function
          try.tolower = function(x)
          {
            y = NA
            try_error = tryCatch(tolower(x), error=function(e) e)
            if (!inherits(try_error, "error"))
              y = tolower(x)
            return(y)
          }

          some_txt = sapply(some_txt, try.tolower)
          some_txt = some_txt[some_txt != ""]
          names(some_txt) = NULL
          return(some_txt)
        }

        ###############

        db_key <- "e86d3246ade555b409caeb6d3c8b77fd"

        print("Getting tweets...")
        keyword = input$Keywd
        # get some tweets
        tweets = searchTwitter(keyword, input$n_tweets, lang="en")
        # get text
        tweet_txt = sapply(tweets, function(x) x$getText())

        # clean text
        tweet_clean = clean.text(tweet_txt)
        tweet_num = length(tweet_clean)
        # data frame (text, sentiment)
        tweet_df = data.frame(text=tweet_clean, sentiment=rep("", tweet_num),stringsAsFactors=FALSE)

        print("Getting sentiments...")
        # apply function getSentiment
        sentiment = rep(0, tweet_num)

        foreach(i=1:tweet_num) %dopar%
        {
          tmp = getSentiment(tweet_clean[i], db_key)

          tweet_df$sentiment[i] = tmp$sentiment

          print(paste(i," of ", tweet_num))

        }

        # delete rows with no sentiment
        tweet_df <- tweet_df[tweet_df$sentiment!="",]

        #separate text by sentiment
        sents = levels(factor(tweet_df$sentiment))
        #emos_label <- emos

        # get the labels and percents
        labels <-  mclapply(sents, function(x) paste(x,format(round((length((tweet_df[tweet_df$sentiment ==x,])$text)/length(tweet_df$sentiment)*100),2),nsmall=2),"%"), mc.cores=8)

        nemo = length(sents)
        emo.docs = rep("", nemo)

        foreach(i=1:nemo) %dopar%
        {
          tmp = tweet_df[tweet_df$sentiment == sents[i],]$text

          emo.docs[i] = paste(tmp,collapse=" ")
        }


        # remove stopwords
        emo.docs = removeWords(emo.docs, stopwords("german"))
        emo.docs = removeWords(emo.docs, stopwords("english"))
        corpus = Corpus(VectorSource(emo.docs))
        tdm = TermDocumentMatrix(corpus)
        tdm = as.matrix(tdm)
        colnames(tdm) = labels

        # comparison word cloud
        cpCloud = comparison.cloud(tdm, colors = brewer.pal(nemo, "Dark2"),
                         scale = c(3,.5), random.order = FALSE, title.size = 1.5)
        cpCloud
      }
    )

####################State word clouds#######################

#Based on different states
    statewise = reactive(
      {
        getSentiment <- function (text, key){

          text <- URLencode(text);

          #save all the spaces, then get rid of the weird characters that break the API, then convert back the URL-encoded spaces.
          text <- str_replace_all(text, "%20", " ");
          text <- str_replace_all(text, "%\\d\\d", "");
          text <- str_replace_all(text, " ", "%20");

          if (str_length(text) > 360){
            text <- substr(text, 0, 359);
          }

          data <- getURL(paste("http://api.datumbox.com/1.0/TwitterSentimentAnalysis.json?api_key=", key, "&text=",text, sep=""))

          js <- fromJSON(data);

          # get mood probability
          sentiment = js$output$result

          return(list(sentiment=sentiment))
        }

        clean.text <- function(some_txt)
        {
          some_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", some_txt)
          some_txt = gsub("@\\w+", "", some_txt)
          some_txt = gsub("[[:punct:]]", "", some_txt)
          some_txt = gsub("[[:digit:]]", "", some_txt)
          some_txt = gsub("http\\w+", "", some_txt)
          some_txt = gsub("[ \t]{2,}", "", some_txt)
          some_txt = gsub("^\\s+|\\s+$", "", some_txt)
          some_txt = gsub("amp", "", some_txt)
          # define "tolower error handling" function
          try.tolower = function(x)
          {
            y = NA
            try_error = tryCatch(tolower(x), error=function(e) e)
            if (!inherits(try_error, "error"))
              y = tolower(x)
            return(y)
          }

          some_txt = sapply(some_txt, try.tolower)
          some_txt = some_txt[some_txt != ""]
          names(some_txt) = NULL
          return(some_txt)
        }

        geocode_state = geoinfo_state[which(geoinfo_state$State==input$State),2]

        db_key <- "e86d3246ade555b409caeb6d3c8b77fd"

        print("Getting tweets...")
        keyword = input$Keywd
        # get some tweets
        tweets = searchTwitter(keyword, input$n_tweets, lang="en",geocode = paste(geocode_state),
                               retryOnRateLimit=200)
        # get text
        tweet_txt = sapply(tweets, function(x) x$getText())

        # clean text
        tweet_clean = clean.text(tweet_txt)
        tweet_num = length(tweet_clean)
        # data frame (text, sentiment)
        tweet_df = data.frame(text=tweet_clean, sentiment=rep("", tweet_num),stringsAsFactors=FALSE)

        print("Getting sentiments...")
        # apply function getSentiment
        sentiment = rep(0, tweet_num)
        foreach(i=1:tweet_num) %dopar%
        {
          tmp = getSentiment(tweet_clean[i], db_key)
          tweet_df$sentiment[i] = tmp$sentiment
          print(paste(i," of ", tweet_num))
        }

        # delete rows with no sentiment
        tweet_df <- tweet_df[tweet_df$sentiment!="",]


        #separate text by sentiment
        sents = levels(factor(tweet_df$sentiment))
        #emos_label <- emos

        # get the labels and percents

        labels <-  mclapply(sents, function(x) paste(x,format(round((length((tweet_df[tweet_df$sentiment ==x,])$text)/length(tweet_df$sentiment)*100),2),nsmall=2),"%"), mc.cores = 8)


        nemo = length(sents)
        emo.docs = rep("", nemo)
        foreach (i=1:nemo) %dopar%
        {
          tmp = tweet_df[tweet_df$sentiment == sents[i],]$text

          emo.docs[i] = paste(tmp,collapse=" ")
        }


        # remove stopwords
        emo.docs = removeWords(emo.docs, stopwords("german"))
        emo.docs = removeWords(emo.docs, stopwords("english"))
        corpus = Corpus(VectorSource(emo.docs))
        tdm = TermDocumentMatrix(corpus)
        tdm = as.matrix(tdm)
        colnames(tdm) = labels

        # comparison word cloud
        cpCloud = comparison.cloud(tdm, colors = brewer.pal(nemo, "Dark2"),
                                   scale = c(3,.5), random.order = FALSE, title.size = 1.5)
        cpCloud
      })

############################################################################################
#################################For the third tab in the main panel########################
############################################################################################
 #all state map

    state_all_map = reactive(
      {
        clean.text <- function(some_txt)
        {
          some_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", some_txt)
          some_txt = gsub("@\\w+", "", some_txt)
          some_txt = gsub("[[:punct:]]", "", some_txt)
          some_txt = gsub("[[:digit:]]", "", some_txt)
          some_txt = gsub("http\\w+", "", some_txt)
          some_txt = gsub("[ \t]{2,}", "", some_txt)
          some_txt = gsub("^\\s+|\\s+$", "", some_txt)
          some_txt = gsub("amp", "", some_txt)
          # define "tolower error handling" function
          try.tolower = function(x)
          {
            y = NA
            try_error = tryCatch(tolower(x), error=function(e) e)
            if (!inherits(try_error, "error"))
              y = tolower(x)
            return(y)
          }

          some_txt = sapply(some_txt, try.tolower)
          some_txt = some_txt[some_txt != ""]
          names(some_txt) = NULL
          return(some_txt)
        }

        GEO_map = matrix(NA, 50, 5)
        Topnum = vector(mode = "numeric", length = 50)
        Topfreq = vector(mode = "numeric", length = 50)
        #keyword = input$Keywd

  for (i in 1:nrow(geoinfo_state)){

        geocode_state = geoinfo_state[i,2]
#stopifnot(nchar(geocode_state)==2)
        print("Getting tweets...")

        # get some tweets
        tweets = searchTwitter(input$Keywd, input$n_tweets, lang="en",geocode = paste(geocode_state),
                               since='2010-01-01')
        # get text
        tweet_txt = sapply(tweets, function(x) x$getText())

        # clean text
        tweet_clean = clean.text(tweet_txt)
        tweet_num = length(tweet_clean)
        # data frame (text, sentiment)
        tweet_df = data.frame(text=tweet_clean, sentiment=rep("", tweet_num),stringsAsFactors=FALSE)

#         count.docs = removeWords(tweet_df$text, stopwords("german"))
#         count.docs = removeWords(tweet_df$text, stopwords("english"))

        all_text <- paste(tweet_df$text, collapse = " ")
        corpus <- Corpus(VectorSource(all_text))
        corpus <- tm_map(corpus, content_transformer(tolower))
        #remove punctuation
        corpus <- tm_map(corpus, removePunctuation)
        #remove numbers
        corpus <- tm_map(corpus, removeNumbers)
        #remove redundant white space
        corpus <- tm_map(corpus, stripWhitespace)
        #remove stopwords in English
        corpus <- tm_map(corpus, removeWords,stopwords("en"))
        dtm <- as.matrix(DocumentTermMatrix(corpus))
        freq <- sort(colSums(dtm),decreasing = TRUE)
        SUMf = sum(freq)
        freq <- as.data.frame(freq)
        Top = freq
        Top$word = row.names(Top)
        rownames(Top) <- NULL
        #key word percentage
        Topnum[i] = round(Top$freq[which(Top$word==tolower(input$Keywd))]/SUMf,4)
        Topfreq[i] = Top$freq[which(Top$word==tolower(input$Keywd))]
        GEO_map[i,] = c(geoinfo_state[i,3],Topnum[i],Topfreq[i],
                        geoinfo_state[i,4],geoinfo_state[i,6])
        }

        GEO_map = as.data.frame(GEO_map,stringsAsFactors = FALSE)
        colnames(GEO_map) = c("State", "Percentage","TotalTweet","Population","Party")

        return(GEO_map)

      }
    )




############################################################################
##################################OUTPUT####################################
############################################################################

##########################################################################################
###############Output for the word clouds ---- first tab in the main panel################
##########################################################################################

#In all, the output are all related to "input$go", which is the "Let's search" button.
#Thus eventReactive is used to prevent the application from running automatically
#when information is updated.

#City word trend table
TableTemp = eventReactive(input$go, {
      if (input$showcitytrend==TRUE){

        trends = getTrends(usid$woeid[which(usid$City == input$City)])
        Trend = matrix(head(trends$name, input$n_topKey))
        colnames(Trend) = input$City
        TrendDF = as.data.frame(Trend,stringsAsFactors = F)
        TrendDF$Rank = seq.int(nrow(TrendDF))
        TrendDF = TrendDF[c(2,1)]
        TrendTable = gvisTable(TrendDF,
                               options=list(width=255, height=650))
        return(TrendTable)
      }
    })

    output$trendtable = renderGvis(
      {
        if(input$showcitytrend==TRUE) {
          TableTemp()
        }
      }
    )
#City word trnd table title
    output$text1 = renderText(
      {
        if(input$showcitytrend==TRUE) {
          "City Hot Tweets Trend"
        } else {
          " "
        }
      }
    )
#state top keyword related words table
    StateTableTemp = eventReactive(input$go, {
      StateKWTable = gvisTable(state_topKey(),options=list(width=255, height=650))
      return(StateKWTable)
    })

    output$Statetable = renderGvis({
      StateTableTemp()
      })

##########################################################################################
##############Output for the word clouds ---- second tab in the main panel################
##########################################################################################
#Overall word cloud
allCloudTemp = eventReactive(input$go, {
      print(overall())
    })

    output$overall_cloud = renderPlot({
        allCloudTemp()
      })
#state word cloud
    stateCloudTemp = eventReactive(input$go, {
      print(statewise())
    })

    output$state_cloud = renderPlot(
      {
        stateCloudTemp()
      }
    )

##########################################################################################
##########Output for the map and bubble graph ---- third tab in the main panel############
##########################################################################################
#Keyword percentage heat map
mapTemp = eventReactive(input$go, {
  map_heat = gvisGeoChart(state_all_map(), locationvar='State', colorvar = 'Percentage',
                  options=list(region='US',projection="kavrayskiy-vii",
                      displayMode="regions", resolution="provinces",
                      colorAxis="{colors:['yellow','red']}",width=650, height=400))
      T <- gvisTable(state_all_map(),
                     options=list(width=390, height=450))

      GT <- gvisMerge(map_heat,T, horizontal=TRUE)
      return(GT)
    })

output$state_map=renderGvis({
        mapTemp()
      })

#Bubble plot
bubbleTemp = eventReactive(input$go, {
      bubble = gvisBubbleChart(state_all_map(), idvar="State",
                               sizevar="Percentage",xvar="Population",yvar="TotalTweet",
                               colorvar="Party",
                               options=list(width=700, height=650,
                                            colorAxis="{colors: [ 'red', 'blue']}"))
      return(bubble)
      })

output$keywd_bubble = renderGvis({
        bubbleTemp()
      })
#
#     output$keywd_bubble=renderGvis(
#       {
#         observeEvent(input$go, {
#
#          bubble = gvisBubbleChart(state_all_map(), idvar="State",
#                                   sizevar="Percentage",xvar="Population",yvar="TotalTweet",
#                                   colorvar="Party",
#                                   options=list(width=700, height=650,
#                                                colorAxis="{colors: [ 'red', 'blue']}"))
#           return(bubble)
#         })
#       }
#     )

     }
)