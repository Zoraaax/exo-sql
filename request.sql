USE beer 

# Partie 1

SELECT
    `ANNEE`,
    `NUMERO_TICKET`,
    `DATE_VENTE`
FROM ticket
WHERE `DATE_VENTE` = '2014-01-15'

SELECT
    `ANNEE`,
    `NUMERO_TICKET`,
    `DATE_VENTE`
FROM ticket
WHERE
    DATE_VENTE BETWEEN '2014-01-15' AND '2014-01-17'

SELECT
    `ANNEE`,
    `NUMERO_TICKET`,
    `DATE_VENTE`
FROM ticket
WHERE
    DATE_VENTE BETWEEN '2014-03-01' AND '2014-03-31'

SELECT
    `ANNEE`,
    `NUMERO_TICKET`,
    `DATE_VENTE`
FROM ticket
WHERE
    DATE_VENTE BETWEEN '2014-03-01' AND '2014-04-30'

SELECT
    `ID_ARTICLE`,
    `NUMERO_TICKET`,
    `QUANTITE`
FROM ventes
WHERE `QUANTITE` >= 50

SELECT `NUMERO_TICKET` FROM ventes WHERE `ID_ARTICLE` = 500 

SELECT
    `ID_ARTICLE`,
    `NOM_ARTICLE`,
    `ID_Couleur`
FROM article
WHERE `ID_Couleur` IS NOT NULL
ORDER BY `ID_Couleur` ASC
LIMIT 1000

SELECT
    `ID_ARTICLE`,
    `NOM_ARTICLE`,
    `ID_Couleur`
FROM article
WHERE `ID_Couleur` IS NULL

SELECT
    `ANNEE`,
    `NUMERO_TICKET`,
    `DATE_VENTE`
FROM ticket
WHERE
    `DATE_VENTE` BETWEEN '2014-03-01' AND '2014-03-31'
    OR `DATE_VENTE` BETWEEN '2014-06-01' AND '2014-06-30'

# Partie 2

SELECT
    `NUMERO_TICKET`,
    SUM(`QUANTITE`) AS `qteTotal`
FROM ventes
GROUP BY `NUMERO_TICKET`
ORDER BY `qteTotal` DESC

SELECT
    `NUMERO_TICKET`,
    SUM(`QUANTITE`) AS `qteTotal`
FROM ventes
GROUP BY `NUMERO_TICKET`
HAVING `qteTotal` > 500
ORDER BY `qteTotal` DESC

SELECT
    `NUMERO_TICKET`,
    SUM(`QUANTITE`) AS `qteTotal`
FROM ventes
WHERE `QUANTITE` > 50
GROUP BY `NUMERO_TICKET`
HAVING `qteTotal` > 500
ORDER BY `qteTotal` DESC

SELECT
    `ID_ARTICLE`,
    `NOM_TYPE`,
    `NOM_ARTICLE`,
    `VOLUME`,
    `TITRAGE`
FROM article
    INNER JOIN type ON article.ID_TYPE = type.ID_TYPE
WHERE `NOM_TYPE` = 'Trappiste'

SELECT
    `NOM_CONTINENT`,
    `NOM_MARQUE`
FROM marque
    INNER JOIN pays ON marque.ID_PAYS = pays.`ID_PAYS`
    INNER JOIN continent ON pays.ID_CONTINENT = continent.ID_CONTINENT
WHERE `NOM_CONTINENT` = 'Afrique'

SELECT
    `NOM_ARTICLE`,
    `NOM_MARQUE`,
    `NOM_PAYS`,
    `NOM_CONTINENT`
from article
    INNER JOIN marque ON marque.`ID_MARQUE` = article.`ID_MARQUE`
    INNER JOIN pays ON pays.`ID_PAYS` = marque.`ID_PAYS`
    INNER JOIN continent ON continent.`ID_CONTINENT` = pays.`ID_CONTINENT`
WHERE `NOM_CONTINENT` = 'Afrique'

SELECT
    ticket.`ANNEE`,
    ticket.`NUMERO_TICKET`,
    ROUND(
        SUM(`QUANTITE` * `PRIX_ACHAT` * 1.15)
    ) as `total_price`
FROM ticket
    INNER JOIN ventes ON ventes.`QUANTITE` = ticket.`NUMERO_TICKET`
    INNER JOIN article ON ventes.`ID_ARTICLE` = article.`ID_ARTICLE`
GROUP BY
    ticket.`ANNEE`,
    ticket.`NUMERO_TICKET`
ORDER BY `total_price` DESC
LIMIT 1;

SELECT
    `ANNEE`,
    ROUND(SUM(`QUANTITE` * `PRIX_ACHAT`)) as CA
FROM ventes
    INNER JOIN article ON ventes.`ID_ARTICLE` = article.`ID_ARTICLE`
GROUP BY `ANNEE`
ORDER BY `ANNEE` ASC

SELECT
    `ANNEE`,
    `NOM_ARTICLE`,
    SUM(`QUANTITE`) as total_quantity_sell
FROM ventes
    INNER JOIN article ON ventes.`ID_ARTICLE` = article.`ID_ARTICLE`
WHERE `ANNEE` = 2016
GROUP BY
    `ANNEE`,
    `NOM_ARTICLE`
ORDER BY
    `total_quantity_sell` DESC

SELECT
    `ANNEE`,
    `NOM_ARTICLE`,
    SUM(`QUANTITE`) as total_quantity_sell
FROM ventes
    INNER JOIN article ON ventes.`ID_ARTICLE` = article.`ID_ARTICLE`
WHERE
    `ANNEE` IN (2014, 2015, 2016)
GROUP BY
    `ANNEE`,
    `NOM_ARTICLE`
ORDER BY
    `ANNEE` ASC,
    `total_quantity_sell` DESC

# Partie 3

SELECT `NOM_ARTICLE`
FROM article
WHERE `ID_ARTICLE` IN (
        SELECT `ID_ARTICLE`
        FROM ventes
        WHERE `ANNEE` = 2014
        GROUP BY `ID_ARTICLE`
        HAVING
            SUM(`QUANTITE`) IS NULL
    )

SELECT
    `NOM_PAYS`,
    `NOM_MARQUE`,
    `NOM_TYPE`
FROM pays
    INNER JOIN marque ON marque.`ID_PAYS` = pays.`ID_PAYS`
    INNER JOIN article ON article.`ID_MARQUE` = marque.`ID_MARQUE`
    INNER JOIN type ON type.`ID_TYPE` = article.`ID_TYPE`
WHERE `NOM_TYPE` = 'Trappiste'

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

SELECT DISTINCT `NUMERO_TICKET`
FROM ventes
WHERE ventes.`ID_ARTICLE` IN (
        SELECT `ID_ARTICLE`
        FROM ventes
        WHERE
            `NUMERO_TICKET` = '2014-856'
    )

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
