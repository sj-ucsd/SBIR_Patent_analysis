# SBIR_Patent_analysis
UCSD MAS DSE203 final project. The project tries to answer questions/queries in the area of innovation by combining multiple data sources. 

The focus of this project is to demonstrate ETL (Extract, Transform, Load) concepts. The goal of the project is to use multiple data sources of desparate formats (structured, semi-structred and unstructed). 

This project uses two data sources:
1. SBIR (Small Business Innovation Research - organization that matches grants from various entities
2. US Patents database

## Overview


## Prepration
A key component of this project is building a classifier that can take a term/phrase and identify whether it is a technical term/phrase or not. This is useful in processing abstracts from SBIR and patent database and filter out any non-technical terms.
To build the classifer, we need 
1. a set of technical terms which are obtained by processing IEEE Thesaurus and vocabulary from ACM. The technical terms are extracted using the notebook <b>process_ieee_thesaurus_acm_terms.ipynb</b> from <b>preprocessing</b> folder.
2. a set of non-technical terms. This is obtained by taking a sample of abstracts from the SBIR dataset and extracting entities using Spacy and filtering any technical terms. The non-technical terms are extracted using the notebookt <b>generate_nontech_terms.ipynb</b> from <b>preprocessing</b> folder.
3. Finally a binary classifier using RandomForrest is created. This is implemented in <b>tech_term_classifier.ipynb</b> from the <b>model</b> folder.
4. The trained model <b>trained_tech_classifier_model.joblib.zip</b>is stored as a zip file in <b>model</b> folder and can be used in subsequent stages. 

