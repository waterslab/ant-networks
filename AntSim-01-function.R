#	AntSim-01-function.R
#	Spatially explicit random interaction simulation
#	JM Toth & JS Waters
#	June 2021

#	The below code is the actual algorithm to run the simulation
#	See manuscript for more information

antsim <- function(size,arena,time,trackingout,graphout){
  unlink(trackingout)
  unlink(graphout)
  tfile <- file(trackingout,"w")
  dfile <- file(graphout,"w")
  
  #Initialize ants
  X = sample(1:arena,size,replace=T)
  Y = sample(1:arena,size,replace=T)
  
  lastint = rep(0,size) #last interaction to prevent duplication
  
  minBound = 0;
  maxBound = arena;
  
  interaction = ""
  coords = ""
  for(t in 1:timesteps){
    print(t)
    
    #Calculate Motion
    for(i in 1:size){
      generating = TRUE
      while(generating){
        invalidX = TRUE
        while(invalidX){
          newX = X[i] + sample(-1:1,1,replace=T)
          if(newX >= minBound && newX < maxBound){
            invalidX = FALSE;
          }
        }
        invalidY = TRUE
        while(invalidY){
          newY = Y[i] + sample(-1:1,1,replace=T)
          if(newY >= minBound && newY < maxBound){
            invalidY = FALSE;
          }
        }
        #Ensure no collisions
        generating = FALSE
        for(j in 1:size){
          if(X[j]==newX && Y[j]==newY && i!=j){
            generating = TRUE;
          }
        }
        X[i] = newX
        Y[i] = newY
      }
    }
    #Calculate Interactions
    for(i in 1:size){
      for(j in 1:size){
        if( abs(X[i]-X[j])<=1 && abs(Y[i]-Y[j])<=1 && lastint[i]!=j && i!=j){
          #Interaction
          lastint[i] = j
          interaction = paste(interaction,i,",",j,",",t,"\n",sep="")
        }
      }
    }
    #Print Coordinates
    for(i in 1:size){
      coords = paste(coords,i,",",X[i],",",Y[i],",",t,"\n",sep="")
    }
    
    if(t%%diskcache == 0){
      cat(interaction,file=dfile,append=T)
      cat(coords,file=tfile,append=T)
      interaction = ""
      coords = ""
    }
  }
  
  close(tfile)
  close(dfile)
}