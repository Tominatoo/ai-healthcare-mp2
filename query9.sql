SELECT
t.formulary_drug_cd,
CAST(AVG(t.dose_val * t.num_doses) AS DECIMAL(10,5)) AS avg_tot_dose,
t.dose_unit_rx,
COUNT(*) as cnt
FROM 
    (SELECT a.SUBJECT_ID, p.formulary_drug_cd, CAST(p.dose_val_rx AS DECIMAL(10,5)) AS dose_val, 
    p.dose_unit_rx, CAST(p.form_val_disp AS DECIMAL(10,5)) AS num_doses
    FROM ADMISSIONS a
    JOIN 
        PRESCRIPTIONS p ON a.SUBJECT_ID=p.SUBJECT_ID
    WHERE  
        CAST(p.dose_val_rx AS DECIMAL(10,5)) IS NOT NULL AND
        CAST(p.form_val_disp AS DECIMAL(10,5)) IS NOT NULL AND
        (p.formulary_drug_cd='LR1000' OR p.formulary_drug_cd='MAG2PM')
    ) t
JOIN
    DIAGNOSES_ICD d ON t.SUBJECT_ID=d.SUBJECT_ID 
WHERE d.ICD9_CODE=4019
GROUP BY t.formulary_drug_cd, t.dose_unit_rx
ORDER BY cnt DESC     

