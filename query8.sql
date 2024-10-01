SELECT rank() OVER (ORDER BY COUNT(*) DESC) as rnk, COUNT(*) as cnt, t.drug, t.formulary_drug_cd 
FROM (SELECT DISTINCT a.SUBJECT_ID, p.drug, p.formulary_drug_cd
FROM ADMISSIONS a
JOIN 
    DIAGNOSES_ICD d ON a.SUBJECT_ID=d.SUBJECT_ID
JOIN 
    PRESCRIPTIONS p ON a.SUBJECT_ID=p.SUBJECT_ID
WHERE d.ICD9_CODE=4019) t
GROUP BY t.drug, t.formulary_drug_cd
ORDER BY cnt DESC
LIMIT 25