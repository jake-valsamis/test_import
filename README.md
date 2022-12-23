# Replicating Jerome's Calcium Imaging Pipeline without the use of GroupTuple

## Purpose
Jerome's pipeline takes movies acquired with Calcium Imaging, uses each movie to tune a DL model, runs the DL model in inference on N chunks of the movie where chunks are defined by json files. Then chunks of each movie are merged into a single file, a segmentation algorithm is ran, and results are collected. 

GroupTuple is used to preserve the identity of each movie and chunks of each movie throughout the pipeline. 

This Toy Pipeline shows how folder and filenames can be used to preserve the identity of movies while achieving the same level of parallelization. Once the flatten operator is added to Code Ocean Pipelines, this pipeline can be made using only the GUI. 

This pipeline's nextflow/timeline.html shows how each capsule is parallelized during the run.

## Data Assets 
**movies:** text files that mimics hdf5 movie files. Each text file contains 3 brain regions which will be separated at the chunking step. 

**json_chunks:** text files that will dictate chunking. For example, instances that receive json_chunks/1_chunk.txt will output a text file with only the first brain region from the original movie. 

## Capsules
**Create Model:** recieves a movie text file (e.g. 1_movie.txt), creates the corresponding "model" (e.g. 1_model.txt), and outputs both the movie and the model in a folder (e.g. 1_movie_and_model)

**Create Chunks:** receives a movie and a model, splits the movie into three chunks based on the file received from json_chunks.

**Run Inference:** copies contents of data to the results folder, there is no actual inference. 

**Group Chunks:** receives outputs from all instances of **Run Inference**, groups them according to which movie they came from. 

**Merge Chunks:** merge all chunks of each movie into one output. 

## Nextflow Operators

Global Toggle on between **json_chunks** and **Create Chunks**, and between **Run Inference** and **Group Chunks**

Add .flatten() between **Create Chunks** and **Run Inference**, and between **Group Chunks** and **Merge Chunks**

