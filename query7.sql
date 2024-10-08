SELECT rank() OVER (ORDER BY COUNT(*) DESC) as rnk, COUNT(*) AS cnt, t.DRUG, t.FORMULARY_DRUG_CD
FROM (SELECT DISTINCT SUBJECT_ID, DRUG, FORMULARY_DRUG_CD FROM PRESCRIPTIONS) t
GROUP BY t.DRUG, t.FORMULARY_DRUG_CD
ORDER BY cnt DESC
LIMIT 25