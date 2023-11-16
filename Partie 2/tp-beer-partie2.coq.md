## 10 Listez pour chaque ticket la quantité totale d’articles vendus. (Classer par quantité décroissante)

```mysql

SELECT `NUMERO_TICKET`, SUM(`QUANTITE`) AS `qteTotal`
FROM ventes
GROUP BY `NUMERO_TICKET`
ORDER BY `qteTotal` DESC

```

## 11 Listez chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500. (Classer par quantité décroissante)

```mysql

SELECT `NUMERO_TICKET`, SUM(`QUANTITE`) AS `qteTotal`
FROM ventes
GROUP BY `NUMERO_TICKET`
HAVING `qteTotal` > 500
ORDER BY `qteTotal` DESC

```

## 12 Listez chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500. On exclura du total, les ventes ayant une quantité inférieure à 50 (classer par quantité décroissante)

```mysql

SELECT `NUMERO_TICKET`, SUM(`QUANTITE`) AS `qteTotal`
FROM ventes
WHERE `QUANTITE` > 50
GROUP BY `NUMERO_TICKET`
HAVING `qteTotal` > 500
ORDER BY `qteTotal` DESC

```

## 13 Listez les bières de type ‘Trappiste’. (id, nom de la bière, volume et titrage)

```mysql

SELECT `ID_ARTICLE`, `NOM_TYPE`, `NOM_ARTICLE`, `VOLUME`, `TITRAGE`
FROM article
INNER JOIN type ON article.ID_TYPE = type.ID_TYPE
WHERE `NOM_TYPE` = 'Trappiste'

```

## 14 Listez les marques de bières du continent ‘Afrique’

```mysql

SELECT `NOM_CONTINENT`, `NOM_MARQUE`
FROM marque
INNER JOIN pays ON marque.ID_PAYS = pays.`ID_PAYS`
INNER JOIN continent ON pays.ID_CONTINENT = continent.ID_CONTINENT
WHERE `NOM_CONTINENT` = 'Afrique'

```

## 15 Lister les bières du continent ‘Afrique’

```mysql

SELECT `NOM_ARTICLE`, `NOM_MARQUE`, `NOM_PAYS`, `NOM_CONTINENT`
from article
INNER JOIN marque ON marque.`ID_MARQUE` = article.`ID_MARQUE`
INNER JOIN pays ON pays.`ID_PAYS` = marque.`ID_PAYS`
INNER JOIN continent ON continent.`ID_CONTINENT` = pays.`ID_CONTINENT`
WHERE `NOM_CONTINENT` = 'Afrique'

```

## 16. Lister les tickets (année, numéro de ticket, montant total payé). En sachant que le prix de vente est égal au prix d’achat augmenté de 15%.

```mysql

```

## 17  Donner le C.A. par année.

```mysql

SELECT `ANNEE`, ROUND(SUM(`QUANTITE` * `PRIX_ACHAT`)) as CA
FROM ventes
INNER JOIN article ON ventes.`ID_ARTICLE` = article.`ID_ARTICLE`
GROUP BY `ANNEE`
ORDER BY `ANNEE` ASC

```

## 18. Lister les quantités vendues de chaque article pour l’année 2016.

```mysql

SELECT 
    `ANNEE`,
    `NOM_ARTICLE`,
    SUM(`QUANTITE`) as total_quantity_sell
FROM ventes
    INNER JOIN article ON ventes.`ID_ARTICLE` = article.`ID_ARTICLE`
WHERE `ANNEE` = 2016
GROUP BY `ANNEE`, `NOM_ARTICLE`
ORDER BY `total_quantity_sell` DESC

```

## 19. Lister les quantités vendues de chaque article pour les années 2014, 2015, 2016.

```mysql

SELECT
    `ANNEE`,
    `NOM_ARTICLE`,
    SUM(`QUANTITE`) as total_quantity_sell
FROM ventes
    INNER JOIN article ON ventes.`ID_ARTICLE` = article.`ID_ARTICLE`
WHERE `ANNEE` IN (2014, 2015, 2016)
GROUP BY `ANNEE`, `NOM_ARTICLE`
ORDER BY `ANNEE` ASC, `total_quantity_sell` DESC

```

