This folder contains files that will need to be run only once and results stored. The results are later used in the project. Details of the files and order of execution:
1. process_ieee_thesaurus_acm_terms.ipynb - Creates a list of technical terms from IEEE thesaurus and ACM terms - The output of this is required for training the model.
2. generate_nontech_terms.ipynb - Creates a list of non-technical terms - The output of of this is required for training the model. 
3. process_sbir_csv.ipynb - Process SIBR dataset especially unstructed data (abstracts) to extract technical terms. Note that Model needs to be trained in model folder before this file is executed
4. process_patent_xml.ipynb - Process Patent dataset to extract technical terms.
5. llama_similarity.ipynb - Find similarity score between Patent and SBIR using LlamaIndex

Other files:
1. spacy_helper_methods.ipynb - Helper functions for spacy pipeline
2. simularity_score_jedai.ipynb - OBSOLETE, no longer used
3. sbir_patent_similarity.ipynb - OBSOLETE, no longer required
   
