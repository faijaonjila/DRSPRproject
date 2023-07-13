dssalaries

### 1 
## categorical variable: job_title  numeric variable: salary_in_usd
## null hypothesis: average salaries of data scientists and ML engineers are the same 
## alternative hypothesis: average salaries of data scientists and ML engineers are different 

dssalariesUS <- dssalaries |> filter(company_location == "US", salary_in_usd > 0)
dssalariesUS |> filter(job_title == "Data Scientist" ,salary_in_usd > 0)
dssalariesUS |> filter(job_title == "ML Engineer" , salary_in_usd > 0)
dscientist <- dssalariesUS |> filter(job_title == "Data Scientist")
mlengineer <- dssalariesUS |> filter(job_title == "ML Engineer")

t.test(dscientist$salary_in_usd, mlengineer$salary_in_usd, paired = F)
# p value is 0.2681
# significant, our findings reject the null hypothesis