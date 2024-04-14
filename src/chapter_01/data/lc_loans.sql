CREATE TABLE IF NOT EXISTS lc_loans (
    status TEXT,
    grade TEXT
);

.import --csv --skip 1 lc_loans.csv lc_loans

CREATE TABLE IF NOT EXISTS lc_loans_count (
    'Grade' TEXT,
    'Charged Off' INTEGER,
    'Current' INTEGER,
    'Fully Paid' INTEGER,
    'Late' INTEGER,
    'Total' INTEGER
);

INSERT INTO lc_loans_count ('Grade', 'Charged Off', 'Current', 'Fully Paid', 'Late', 'Total')
SELECT
    grade,
    SUM(CASE WHEN status = 'Charged Off' THEN 1 ELSE 0 END) AS 'Charged Off',
    SUM(CASE WHEN status = 'Current' THEN 1 ELSE 0 END) AS 'Current',
    SUM(CASE WHEN status = 'Fully Paid' THEN 1 ELSE 0 END) AS 'Fully Paid',
    SUM(CASE WHEN status = 'Late' THEN 1 ELSE 0 END) AS 'Late',
    COUNT(*) AS 'Total'
FROM
    lc_loans
GROUP BY
    grade;

INSERT INTO lc_loans_count ('Grade', 'Charged Off', 'Current', 'Fully Paid', 'Late', 'Total')
SELECT
    'Total' AS 'Grade',
    SUM(CASE WHEN status = 'Charged Off' THEN 1 ELSE 0 END) AS 'Charged Off',
    SUM(CASE WHEN status = 'Current' THEN 1 ELSE 0 END) AS 'Current',
    SUM(CASE WHEN status = 'Fully Paid' THEN 1 ELSE 0 END) AS 'Fully Paid',
    SUM(CASE WHEN status = 'Late' THEN 1 ELSE 0 END) AS 'Late',
    COUNT(*) AS 'Total'
FROM
    lc_loans;

