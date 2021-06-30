#	AntSim-02-simulation-loop.R
#	Spatially explicit random interaction simulation
#	JM Toth & JS Waters
#	June 2021

#	The below code is the loop to run the antsim() simulation  
#	based on the antsim() function defined in the AntSim-01-function.R file
#	See manuscript for more information

#	set working directory
setwd("~/Desktop")

#	1. Define the range of group sizes that should be simulated
#	2. Specify how large the (squre) virtual arena should be
#	3. Indicate how long the simulation should run
#	4. Optionally, edit the file names of the saved output files

for (i in 0:510){
	size <- 5+i
	arena <- 100
	timesteps <- 100
	trackingout <- paste("coordinates_", size, ".txt", sep="")
	graphout <- paste("interactions_", size, ".txt", sep="")
	
	# This input decides how much the program will store before writing to disk. 
	# Tune this to whatever makes the program run fast.
	diskcache = 10 
	
	#	This section stores metadata
	metadata <- paste("Colony Size: ",size,"\n",
	      "Arena Size: ",arena,"\n",
	      "Time Steps: ",timesteps,"\n"
	      ,sep="")
	metafile <- file("metadata.txt")
	writeLines(metadata,metafile)
	close(metafile)
	
	antsim(size, arena, time, trackingout, graphout)
	}