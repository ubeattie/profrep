#Appendix S1.  R code for calculating PR (Pattern Repeatability)
#Ordering individuals by combination of variances at each time point and the number of crossovers
#Assumptions:
#1. File name will indicate the number of rows (times of observations) per individual animal.
#2. This number will remain consistent for all individuals reported on in the file

#UKB note - ID must be first column called "Animal"
#time must be second column called "TIME"

#no user input required beyond this point

my_sigmoid <- function(x) {return(1.0/(1 + exp(-x)))}



get_vars <- function  (i, individuals, nreplicates) {
  #For the given individual i, for given time, computes variance in values over replicates. 
  #Returns these variances, sum of all values (for all times and replicates),
  #sum of all these values squared, and the number of values "
  vars = c()
  obj <- individuals[[i]]
  local_rows <- nrow(obj)
  #check for missing reps
  for (k in 3:(2 + nreplicates)) #over replicates
  {on_time <- obj[1:nrow(obj), k]
  not_na = 0
  for (t in on_time)
  {if (!is.na(t))
  {not_na = not_na + 1}}
  if (not_na == 0) {#print(c('------>', obj$Animal, 'no data for rep', (k - 2)))}
  }}
  #find variances
  lens = c()
  all_nbrs <- c()
  all_squares <- c()
  for (j in 1:local_rows) # over number of rows (i.e. time stamps)
  {
    nbrs_at_j = c() #collecting values for all reps at jth measurement time
    for (k in 3:(2 + nreplicates)) #over replicates
    {
      there <- obj[j,k]
      if (!is.na(there))
      {nbrs_at_j <- c(nbrs_at_j, there)
      all_nbrs <- c(all_nbrs, there)
      all_squares <- c(all_squares, there*there)}
    }
    len <- length(nbrs_at_j)
    len_all <- length(all_nbrs) #product of number of time samples and replicates with values
    lens = c(lens,len)
    
    #now compute variance at jth measurement time
    if (len > 1) {#need more than one value to compute meaningful variance
      #print(c('nbrs', var(nbrs_at_j), (len-1)*var(nbrs_at_j)/len))
      #pop_v_at_time <- (len - 1)*var(nbrs_at_j)/len #note: switch to population variance
      vars <- c(vars, var(nbrs_at_j))} #add to list of variances
    else {vars <- c(vars,0)}}
  sum_of_vals <- sum(all_nbrs)
  ssq <- sum(all_squares)
  return(c(vars, sum_of_vals, ssq, len_all))
}


get_good_values <- function(indiv,t, nreplicates) {
  #deal with missing data; returns good values at time t
  use_set = c()
  for (j in 3:(3 + nreplicates -1)) {#for each replicate
    if (!is.na(indiv[t,j])) {
      use_set <- c(use_set, j)}
  }
  if (is.null(use_set))
  {return(NULL)}
  if (length(use_set) == 1)
  {return(NULL)}
  return(use_set)
}


handle_missing_data <- function(data, ntimes, nreplicates) {
  nmissing <- 0
  missing_set <- c()
  for (t in 1:ntimes) {
    for (irep in 1:nreplicates) {
      if (is.na(data[t, irep + 2])) 
      {#find nxt good datapoint
        #cat('missing at', t, irep, '\n')
        nmissing <- nmissing + 1
        missing_set <- c(missing_set, t*(nreplicates - 1) + irep)
        use <- -999
        proceed <- 1
        if ((irep + 1) < nreplicates) {
          for (krep in (irep + 1):nreplicates) #look ahead
          {#cat('krep', krep, '\n')
            nxt <- data[t, krep + 2]
            #cat('nxt', nxt, length(nxt), '\n')
            if (proceed) 
            {if (nchar(nxt) > 1 & !is.na(nxt))
            {proceed <- 0
            use <- nxt}
              else {#cat('still missing at', t, krep, '\n')
                missing_set <- c(missing_set, t*(nreplicates -1) + krep)
                nmissing <- nmissing + 1}}}} #set to first available values
        if (use == -999)
        {#cat('no right sided value \n')
          use <- data[t, irep + 1]}
        replacement <- data[t, irep + 1] + use/2
        data[t, irep + 2] <- replacement}}}
  if (nmissing > 0) {}#cat('number missing', nmissing, '\n')
  #cat('number missing in next is', length(unique(missing_set)), '\n')}
  return(data)
}


do_crossings <- function(data1, ntimes, nreplicates) {
  "Computes the number of crossovers"
  indicators <- c()
  data <- handle_missing_data(data1, ntimes, nreplicates)
  for (t in 1:ntimes)
  {for (irep in 1:(nreplicates - 1)) {
    there <- data[t, irep + 2]
    for (jrep in (irep + 1):nreplicates) {
      nxt <- -1
      if (there >= data[t,jrep + 2]) {
        nxt <- 1}
      #cat('nxt', t, irep, '->', jrep, there, '>', data[t,jrep], 'yields', nxt, '\n')
      indicators <- c(indicators, nxt)
    }       
  }}
  npairs = nreplicates*(nreplicates - 1)/2
  M = matrix(indicators, npairs, ntimes)
  #cat(M, '\n')
  ncrossings = 0
  for (t in 1:(ntimes - 1)) {
    for (i in 1:npairs){
      if (M[i,t]*M[i,t + 1] == -1){
        ncrossings = ncrossings + 1}}}
  return(ncrossings)
}

get_score <- function(i, maxvar, var_set, sum_of_vals, sd, ssq, nrows, nfeatures, nreplicates, individuals) {
  "Computes a score based on variances and crossovers "
  #factor balances the contribution from number crossovers
  nbr_crossings <- do_crossings(individuals[[i]], nrows, nreplicates)#get_ud(i)#
  nx_of_ten <- round(0.01, 2)
  if (nbr_crossings > 0) {
    nx_of_ten <- round(20.0*nbr_crossings/((nrows -1)*nreplicates*(nreplicates - 1)), 0)}
  factor <- maxvar/5
  #cat('checking', max(var_set), factor*nx_of_ten)
  score <- max(var_set) + 1.0*sum(var_set)/length(var_set) + factor*nx_of_ten
  cat(i,'\t', nbr_crossings,'\t', round(max(var_set),1),'\t', round(1.0*sum(var_set)/length(var_set),1),'\t',round(score,2), '\t', 1 - my_sigmoid(score/100 - 5), '\n')
  return(score)
}

# collect the scores for each individual
do_ordering <- function(nrows, ids, individuals, nreplicates) {
  cat('Id      Xings \t Maxvar  Avervar   Base \t Score \n')
  score_data <- c()
  scores <- c()
  maxvars <- c()
  #compute balancing factor = maxvars and then compute scores
  for (j in ids) {
  pair <- get_vars(j, individuals, nreplicates) #vars, s, ssq, length(all_nbrs)))
  nbr <- length(pair)
  var_set <- pair[1:(nbr - 3)]
  sum_of_vals <- pair[nbr - 2]
  nfeatures <- pair[nbr]
  sd <- sqrt(pair[nbr -1]/(nfeatures - 1) - nfeatures*(sum_of_vals/nfeatures)**2/(nfeatures - 1))
  ssq <- pair[nbr-1]
  #cat('v_set', j, var_set, v_set,'\n')
  maxvar <- max(var_set)
  maxvars <- c(maxvars, maxvar)
  current <- get_score(j, maxvar, var_set, sum_of_vals, sd, ssq, nrows,nfeatures, nreplicates, individuals)
  scores <- c(scores, current)
  score_data <- c(score_data,current)#for original ordering after scores are ordered
  }
  #Now order the scores and individuals
  order1 <- c()
  for (x in sort(scores)) {
    nxt = 0
    for (i in ids)
    {nxt = nxt + 1
    if (x == score_data[nxt]) {
      order1 <- c(order1, i)  
    }
    }
  }
  print_results(order1, ids)
}

print_results <- function(order1, ids) {
  "Prints ranked results"
  order_lst1 <- c()
  for (o in order1) {
    order_lst1 <- c(order_lst1, ids[o])}
  cat(c('rank order \n'))
  cat(c(order1,'\n'))# 'cat(order_lst1, '\n')
  cat(c('_______________ \n'))
}

profrep <- function(items, nrows) {
  NIndividuals = nrow(items)/nrows
  nreplicates <- ncol(items) - 2
  ncols <- ncol(items)
  names = items$Animal #this is why "Animal" must be the name of the first column
  ids <- unique(names)
  individuals <- list()
  for (j in ids ) {
    individuals[[j]] <- subset(items, Animal == j)}
  do_ordering(nrows, ids, individuals, nreplicates)
  }


#the way it prints is weird/never aligned
#i wanna see if we can save it as a dataframe? and maybe have rank be a column instead a line at the bottom

#also want to take out the "of_10" column in the output


