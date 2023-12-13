# SBIR_Patent_analysis
UCSD MAS DSE203 final project.

The project tries to answer questions/queries in the area of innovation by combining multiple data sources.

The focus of this project is to demonstrate ETL (Extract, Transform, Load) concepts. The goal of the project is to use multiple data sources of desparate formats (structured, semi-structred and unstructed). 

## Authors
Sagar Jogadhenu, Prakhar Shukla, Laben Fisher

## Objective: 
Build a knowledge base to facilitate easy query of research areas and link companies

##  Target Use cases: 
Partnership Targeting: Find synergies between companies working in similar areas/technologies
Money flow/Research Trends: Understanding where investments are being prioritized
Understanding effects of social policy impact on investments: How much funding are disadvantage or minority small businesses are receiving

## Prerequisites
1.  ast
2.  bs4
3.  import_ipynb
4.  io
5.  itertools
6.  joblib
7.  json
8.  llama_index
9.  lxml
10. nltk
11. os
12. Pandas
13. py2neo
14. Python 3.9
15. re
16. requests
17. scipy 1.11.4
18. sklearn
19. spacy 3.7.2
20. subprocess
21. time
22. en_core_web_lg
23. en_core_sci_lg-0.5.3


Note: Other files will be needed if notebooks in the depricated folder are run. 
The depricated folder contains EDA and ML test that are not needed in the deliverable of the current baseline. They are there for reference purposes only.

## Installation Commands used in the various notebooks in this project
It is recommended to just run the neo4j_graph_etl.ipynb file to generate the graph data base and to run the associated queries. If that is all that is needed, 
then it is recommended to skip this complete installation section and just run install the packages needed for that notebook. The reason for this is that this 
project developed a modular approach and had intermediate data files generated after each stage of the pipeline. All the files and intermediate files have already 
been run and the final module, the creation of the graph data base and running of queries can be executed withour rerunning these other files. 

If it is desired to run each notebook to validate the notebooks or to update intermediate files, then running each of this installation scripts up front would 
be usefull. When running the preprocessing files, errors did arise when running files multiple times and having multiple kernels running as well. It is recommended that one file at a time is run and when done, the kernal is shut down before running the next file just to be certain there is no conflicts. 

!pip install bs4
!pip install import-ipynb 
!pip install jsonpath-ng
!pip install spacy

One of these two methods for isntalling en_core_web_lg should work for the target environment
!pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_lg-3.0.0/en_core_web_lg-3.0.0.tar.gz
!python -m spacy download en_core_web_lg to be installed

To download en_core_sci_lg language model used for the tests, uncomment and run the following line
The en_core_sci_lg-0.5.3 model was run on spacy 3.6.1 and will provide a warning message saying it may not operate correctly with spacy 3.7.2
For this project spacy 3.7.2 is needed and the model operated without issue and can be run in this manner. 
Future iterations of this effort could work this descripency between versions of dependecies.
```
!pip install scispacy
!pip install --upgrade scipy
!pip install https://s3-us-west-2.amazonaws.com/ai2-s2-scispacy/releases/v0.5.3/en_core_sci_lg-0.5.3.tar.gz 
```
    
## Data URLs
This URLs are were the base level data comes from for this project. The patent data will need to be manually downloaded and placed in the input_files folder.
The SBIR Award Data will be accessed at run time, so a internet connection will be needed.
The IEEE and ACM data files are already stored in the input_files folder.
```
Patent Data: https://bulkdata.uspto.gov/data/patent/application/redbook/fulltext/2023/ipa230720.zip 
SBIR Award Data: https://data.www.sbir.gov/awarddatapublic/award_data.csv
IEEE Data: https://www.ieee.org/publications/services/thesaurus-access-page.html
ACM Data: https://csrc.nist.gov/glossary
```

## Prepration
A key component of this project is building a classifier that can take a term/phrase and identify whether it is a technical term/phrase or not. This is useful in processing abstracts from SBIR and patent database and filter out any non-technical terms.
To build the classifer, we need 
1. a set of technical terms which are obtained by processing IEEE Thesaurus and vocabulary from ACM. The technical terms are extracted using the notebook <b>process_ieee_thesaurus_acm_terms.ipynb</b> from <b>preprocessing</b> folder.
2. a set of non-technical terms. This is obtained by taking a sample of abstracts from the SBIR dataset and extracting entities using Spacy and filtering any technical terms. The non-technical terms are extracted using the notebookt <b>generate_nontech_terms.ipynb</b> from <b>preprocessing</b> folder. The notebook <b>spacy_helper_methods.ipynb</b> has Spacy based helper functions to lemmatize and extract entities from SBIR abstracts. The notebook is loaded by other notebooks. 
3. Finally a binary classifier using RandomForrest is created. This is implemented in <b>tech_term_classifier.ipynb</b> from the <b>model</b> folder.
4. The trained model <b>trained_tech_classifier_model.joblib.zip</b> is stored as a zip file in <b>model</b> folder and can be used in subsequent stages. 

## Extraction of technical terms
Once necessary preparation is done, we are ready to do entity extraction. Entity extraction is done on patent dataset which is in xml format and SBIR dataset which is in csv format. For patents xml file, there is additional preprocessing done. The steps involved in technical terms is same for both datasets and as follows:
1. Lemmatize the abstract field of each dataset. Additionally lemmatize the claims field in patent dataset - Spacy is used
2. Extrac entities from the lemmatized text for each column - Scispacy is used
3. Run the extracted entities in 2 through the binary RandomForrest classifier that was previously trained for identifying technical terms
4. Save the filtered results in a csv file: <b>patents.json</b> and <b>sbir_1k_sample.csv</b>. Note that these files only contain 1k sample records. Uncomment cells in the notebook to get full set of records. 

The notebooks used to generate technical entities are:
1. <b>process_patent_xml.ipynb</b>
2. <b>process_sbir_csv.ipynb</b>

## Semantic similarity
Semantic similarity between abstracts of SBIR and Patent dataset is performed using LlamaIndex from OpenAI. The semantic similarity is implemented in the notebook <b>llama_similarity.ipynb</b> in the preprocessing folder. This notebook first create a set of tuples with one element of the tuple representing SBIR record and another element representing the patent record. Abstracts corresponding to each tuple is passed to the LlamaIndex Semantics similarity function. Only tuples that pass the 0.8 similarity threshold are retained. The output is stored in </b> llama_similarity.csv </b> in preprocessed_files folder. 

## Final graph creation in neo4j
Now that we have generated all necessary files, the knowledge graph in neo4j is created by further processing the data and creating nodes and edges. This is performed by <b> neo4j_graph_etl.ipynb </b> at the top level. For this notebook to run, neo4j desktop application may need to be open to get the connection details that need to be updated in the notebook. 

## Order of notebook execution
1. Ensure all input files are available. Some input files such as patents XML need ot be downloaded using URLs provided above
2. Run following notebooks to create technical dictionary in any order in the <b>preprocessing</b> folder:
   * <b>process_ieee_thesaurus_acm_terms.ipynb</b> - Produces <b> tech_terms.txt </b> in <b>preprocessed_files</b> folder
   * <b>generate_nontech_terms.ipynb</b> - Produces </b> non_tech.txt </b> in <b>preprocessed_files</b> folder
3. Run <b>tech_term_classifier.ipynb</b> notebook in <b>model</b> folder. Produces a model file <b>trained_tech_classifier_model.joblib</b>. Note that we manually compressed this file to upload to github so you will only see zip file as the generated file is too huge to upload as is. 
4. Run following notebooks from <b>preprocessing</b> folder in any order:
   * <b>process_patent_xml.ipynb</b> - Generates <b> patents.json</b> in <b>preprocessed_files</b> folder
   * <b>process_sbir_csv.ipynb</b> - Generates <b> sbir_1k_sample.csv </b> in <b>preprocessed_files</b> folder
   * <b>llama_similarity.ipynb</b> - Generates <b> llama_similarity.csv </b> in <b>preprocessed_files</b> folder
5. Finally run the <b>neo4j_graph_etl.ipynb</b> from the top level folder. Generates a knowledge graph that can be accessed either via notebook or via neo4j desktop. 
