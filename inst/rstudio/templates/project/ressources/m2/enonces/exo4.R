# ---
# title: "Exercice 4 -  module 2"
# ---  
# Sur les données `FormationPreparationDesDonnees.RData`, table `exercice` :
# 1/ calculer le taux de quantification pour chaque molécule et chacune des années : chaque molécule est identifiée par son `code_parametre`,
# le taux de quantification est le nombre de fois qu'une molécule est retrouvée (càd si `code_remarque` = 1) sur le nombre de fois où elle a été
# cherchée (càd si `code_remarque` = 1, 2, 7 ou 10). Pour cela :
#  - créer la variable `annee`
#  - créer la variable de comptage des présences pour chaque analyse (1=présent, 0=absent)
#  - créer la variable de comptage des recherches pour chaque analyse (1=recherchée, 0=non recherchée)
#  - pour chaque combinaison `annee` x `code_parametre`, calculer le taux de quantification
# 2/ trouver pour chaque station, sur l’année 2016, le prélèvement pour lequel la concentration cumulée, toutes substances confondues,
# est la plus élevée (~ le prélèvement le plus pollué). Pour cela :
#  - filtrer les concentrations quantifiées (`code_remarque`=1) et l’année 2016
#  - sommer les concentrations (`resultat_analyse`) par combinaison `code_station` x `code_prelevement`
#  - ne conserver que le prélèvement avec le concentration maximale



