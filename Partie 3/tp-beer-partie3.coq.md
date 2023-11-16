# TP Beez - Partie 3

> Vous devrez utiliser des sous requêtes pour toutes les questions !

## 20. Listez les articles qui n’ont fait l’objet d’aucune vente en 2014.

```mysql

FROM article
WHERE `ID_ARTICLE` IN (
        SELECT `ID_ARTICLE`
        FROM ventes
        WHERE `ANNEE` = 2014
        GROUP BY `ID_ARTICLE`
        HAVING
            SUM(`QUANTITE`) IS NULL
    )

```

## 21. Codez de 2 manières différentes la requête suivante : Listez les pays qui fabriquent des bières de type ‘Trappiste’.

### Méthode 1 - Avec jointure

```mysql

SELECT
    `NOM_PAYS`,
    `NOM_MARQUE`,
    `NOM_TYPE`
FROM pays
    INNER JOIN marque ON marque.`ID_PAYS` = pays.`ID_PAYS`
    INNER JOIN article ON article.`ID_MARQUE` = marque.`ID_MARQUE`
    INNER JOIN type ON type.`ID_TYPE` = article.`ID_TYPE`
WHERE `NOM_TYPE` = 'Trappiste'

```

### Méthode 2 - Avec sous Requête

```mysql

SELECT `NOM_PAYS`
FROM pays
WHERE `ID_PAYS` IN (
        SELECT `ID_PAYS`
        FROM marque
        WHERE `ID_MARQUE` IN (
                SELECT
                    `ID_MARQUE`
                FROM article
                WHERE
                    `ID_TYPE` IN (
                        SELECT
                            `ID_TYPE`
                        FROM
                            type
                        WHERE
                            `NOM_TYPE` = 'Trappiste'
                    )
            )
    )

```

## 22. Listez les tickets sur lesquels apparaissent un des articles apparaissant aussi sur le ticket 2014-856.

```mysql

SELECT DISTINCT
    `NUMERO_TICKET`
FROM ventes
WHERE ventes.`ID_ARTICLE` IN (
    SELECT `ID_ARTICLE`
    FROM ventes
    WHERE `NUMERO_TICKET` = '2014-856'
)

```

## 23. Listez les articles ayant un degré d’alcool plus élevé que la plus forte des trappistes.

```mysql

SELECT
    `NOM_ARTICLE`,
    `TITRAGE`
FROM article
WHERE `TITRAGE` > (
        SELECT MAX(`TITRAGE`)
        FROM article
        WHERE `ID_TYPE` = (
                SELECT
                    `ID_TYPE`
                FROM type
                WHERE
                    `NOM_TYPE` = 'Trappiste'
            )
    )
ORDER BY `TITRAGE` DESC

```

## 24. Afficher les quantités vendues pour chaque couleur en 2014.

```mysql

SELECT `NOM_COULEUR`, (
        SELECT
            SUM(`QUANTITE`)
        FROM article
            INNER JOIN couleur ON article.`ID_COULEUR` = couleur.`ID_COULEUR`
            INNER JOIN ventes ON ventes.`ID_ARTICLE` = article.`ID_ARTICLE`
        WHERE
            `ANNEE` = 2014
            AND couleur.`NOM_COULEUR` = c.`NOM_COULEUR`
    ) as total_quantity_sell
FROM couleur c
ORDER BY
    `total_quantity_sell` DESC

```

## 25. Donnez l’ID, le nom, le volume et la quantité vendue des 20 articles les plus vendus en 2016.

```mysql

SELECT
    `ID_ARTICLE`,
    `NOM_ARTICLE`,
    `VOLUME`,
    (
        SELECT
            SUM(`QUANTITE`)
        FROM ventes
        WHERE
            `ID_ARTICLE` = article.`ID_ARTICLE`
            AND `ANNEE` = 2016
    ) as total_quantity_sell
FROM article
ORDER BY
    `total_quantity_sell` DESC LIMIT 20

```

## 26. Donner l’ID, le nom, le volume et la quantité vendue des 5 ‘Trappistes’ les plus vendus en 2016.

```mysql

SELECT
    article.`ID_ARTICLE`,
    article.`NOM_ARTICLE`,
    article.`VOLUME`,
    (
        SELECT
            SUM(`QUANTITE`)
        FROM ventes
        WHERE
            `ID_ARTICLE` = article.`ID_ARTICLE`
            AND `ANNEE` = 2016
    ) as total_quantity_sell
FROM article
ORDER BY
    `total_quantity_sell` DESC LIMIT 20


SELECT
    article.`ID_ARTICLE`,
    article.`NOM_ARTICLE`,
    article.`VOLUME`,
    (
        SELECT
            SUM(`QUANTITE`)
        FROM ventes
        WHERE
            `ID_ARTICLE` = article.`ID_ARTICLE`
            AND `ANNEE` = 2016
    ) as total_quantity_sell
FROM article
    INNER JOIN type ON type.`ID_TYPE` = article.`ID_TYPE`
WHERE
    type.`NOM_TYPE` = 'Trappiste'
ORDER BY
    `total_quantity_sell` DESC
LIMIT 5;

```

----

# Pour les plus à l'aise

Si vous avez terminé, rendez-vous sur la partie 4 !


