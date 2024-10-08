SELECT t.GENDER, AVG(t.age)
FROM ADMISSIONS a 
JOIN 
    DIAGNOSES_ICD d ON a.SUBJECT_ID=d.SUBJECT_ID 
JOIN
    (SELECT *, DATEDIFF(DOD, DOB) / 365 AS age
    FROM PATIENTS
    WHERE EXPIRE_FLAG=1
    HAVING age < 120) t ON a.SUBJECT_ID=t.SUBJECT_ID
WHERE d.ICD9_CODE=4019
GROUP BY t.GENDER