use "F:\3-Advanced Econometrics I\Practice\Data\Verbeek2008-ch5-schooling.dta", clear 

*1
describe

*2
summarize

*3.1
regress LWage Schooling Exper Exper2 SMSA South

*3.2
display _b[Exper]+2*_b[Exper2]*1
display _b[Exper]+2*_b[Exper2]*5
display _b[Exper]+2*_b[Exper2]*10
display _b[Exper]+2*_b[Exper2]*20
display _b[Exper]+2*_b[Exper2]*30
display _b[Exper]+2*_b[Exper2]*45

*3.3
display invt(3010-6,0.975)
display 2*ttail(3010-6,9.52)
summarize Exper
test Exper+2*Exper2*8.856146=0

*4.1
regress Schooling NearCollege Exper Exper2 SMSA South

*4.2 (alternative 1)
predict schoolhat
regress LWage schoolhat Exper Exper2 SMSA South

*4.2 (alternative 2)
ivregress 2sls LWage (Schooling = NearCollege) Exper Exper2 SMSA South

*4.4
estat endogenous
quietly ivregress 2sls LWage (Schooling = NearCollege) Exper Exper2 SMSA South, vce(robust)
estat endogenous

*5 (4.2)
ivregress gmm LWage (Schooling = NearCollege) Exper Exper2 SMSA South, wmatrix(unadjusted)

*5 (4.4)
estat endogenous
quietly ivregress gmm LWage (Schooling = NearCollege) Exper Exper2 SMSA South
estat endogenous

*6.1
ivregress gmm LWage (Schooling = NearCollege DadCollege MomCollege) Exper Exper2 SMSA South

*6.2
estat endogenous

*6.3
estat overid
estat firststage

