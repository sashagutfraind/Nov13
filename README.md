# Graphical database of the ISIS/ISIL network in Europe

* Source network data is in create_network.R
* Output networks are found is in the .csv and .gml files
* To run the interactive network dataset, download the HTML file and the files in the folder ise_interactive_network_files.

Submissions of new data are encouraged!
Copy of the paper is available from this repository:
https://github.com/sashagutfraind/Nov13/raw/master/gutfraind15_parisNov13attacks.pdf 

Full processing sequence:
1. Install Neo4j database and configure it by following the documentation in create_network.R
2. create_network.R: Load the data into the database
3. export_network.R: Export the data
4. analysis.R:       provide statistics and visualizations


Please cite the original publication:
```A Graph Database Framework for Covert Network Analysis: An Application to the Islamic State Network in Europe``` 
by A. Gutfraind and M. Genkin, Social Networks 2017.  http://dx.doi.org/10.1016/j.socnet.2016.10.004
