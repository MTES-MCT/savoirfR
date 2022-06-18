---
title: "How to : comment contribuer à savoirfR"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{How to : Comment contribuer à savoirfR}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---


## Ajouter des exercices à un module

### Créer une branche.
En partant de la branche master, créer une branche spécifique

### Rajouter les données manquantes dans `inst/extdata`

Chaque jeu de données doit être limité en taille à quelques centaines de lignes et quelques colonnes.

Compléter le fichier `extdata/list_data_modules.csv` en rajoutant une ligne pour chaque dataset du module.

### Ajouter les exercices dans `inst/vignettes/nom_du_module/`

Chaque fichier d'exercice doit être nommé `exoN.Rmd` ou `exoN.rmd` ou encore `exoN.rmarkdown`.  

Il commence par :   
\---     
title: "Exercices X - module Y"        
\---    
où X est le numéro de l'exercice et Y le numéro du module.  

Suivent :   

- les consignes de l'exercice,   
- un éventuel chunk de setup (library, données à charger...) qui ne sera pas visible dans la correction ni dans la vignette du module, mais sera exécuté,   
- la solution.  

La solution est introduite par la ligne :   
'Résultat attendu : '   
Commence ensuite le chunk contenant les lignes de corrigé.  
Ce chunk est nommé 'modY_exo1_solution'; par exemple :   

\ ```{r mod5_exo1_solution, message=FALSE, warning=FALSE}         


Knitter la vignette pour vérifier qu'elle compile.

## Propagation des exercices (consignes et solutions) aux différents endroits requis

Chaque énoncé/corrigé d'exercice doit figurer :   

1. dans le projet d'exercices du stagiaire (dossier `/inst/rstudio/templates/project/ressource`) 
2. dans la vignette relative au module du package savoirfR (dossier `vignette`)    
3. dans le support de cours du module.

La procédure proposée permet de tenir les différents supports cohérents entre eux au cours du temps et évite les multiples manipulations de mise à jour.

### Projet d'exercices du satgiaire
Pour propager les vignettes d'exercice écrites précédemment vers le projet du stagiaire, exécuter `extract_r_files(module = Y)` et consignez le dans le devstuff_history.R s'il n'est pas déjà inscrit. 

Vérifier que les fichiers R ont bien été extraits dans les dossiers :

* `inst/rstudio/templates/project/ressources/mY/enonces`

* `inst/rstudio/templates/project/ressources/mY/corrections`

### Créer ou modifier la vignette du module.  

Chaque vignette de module rassemble les consignes des différents exercices et visualise le résultat à obtenir, sans dévoiler la correction.

Pour appeler l'exercice dans la vignette ou dans parcours-r, il faut utiliser un chunk. Par exemple pour l'exercice 1 du module 5 : 

\```{r mod5_exo1, child=charge_exo("m5", "exo1.rmd"), echo=FALSE}   

\```  

Compiler votre vignette pour la vérifier. 

### Connecter le support de cours aux énoncés et corrigés de savoir fR.
Ouvrez le projet RStudio dédié au module dont vous venez de mettre à jour les exercices dans {savoirfR}.
Remplacez y les consignes par :
\```{r modY_exoX, child=charge_exo("mY", "exoX.rmd"), echo=FALSE}   

\``` 

Remplacez y les corrigés par :
\```{r modY_exoX_solution, child=charge_exo("mY", "exoX.rmd"), echo=TRUE}  

\``` 


## Testez que tout fonctionne

- faites un check du package

- appuyer sur install & restart

- mettez-vous à la place du stagiaire en créant un projet d'exercices avec {savoirfR} du module mis à jour.


## Intégrer vos changements à la branche principale

### {savoirfR}

- commiter les changements de savoirfR
- effectuer une demande de merge request de votre branche vers la branche principale 

Une fois la branche master à jour de vos modifications, constatez les améliorations que vous avez apportées sur https://mtes-mct.github.io/savoirfR/index.html.  

### Support de cours

- commiter les changements du support de cours
- effectuer une demande de merge request de votre branche vers la branche principale 

Une fois la branche master à jour de vos modifications, constatez les améliorations que vous avez apportées sur le support à partir de https://mtes-mct.github.io/parcours-r/ .
