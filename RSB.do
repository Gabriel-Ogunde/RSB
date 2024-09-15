***************DETERMINANTS OF RISKY SEXUAL BEHAVIOUR AMONG FEMALE ADOLESCENT IN LOW INCOME COMMUNITIES IN IBADAN*************************

recode A1 (13/15=1 "13-15 yrs") (16/max=2 "Above 15 yrs"), gen(age_grp)
recode A2 (1 2=1 "< 1 yr") (5/10=2 "1-10 yrs") (11/15 3=3 "Lived all her life") (4=4 "Don't know"), gen(length_stay)
recode A3 (1 3=1 "Christianity") (2=2 "Islam"), gen(religion)
recode A4 (1=1 "Yoruba") (2/4=2 "Non-Yoruba"), gen(ethnicity)
recode A10 (1=1 "Living with parents") (2 3=2 "Living with mother/father") (4 5=3 "Living with other family/adult/caregiver"), gen(living_with)
recode A12 (1=1 "None") ( 2=2 "1 night") ( 3=3 "2-3 nights") (4 5=4 ">3 nights"), gen(night_sleep)

gen no_sexual_partners=1 if G10=="1" | G10=="1.0"
replace no_sexual_partners=2 if no_sexual_partners==. & G10!=""

recode G11 (0 1=0 "No") (3 4 5=1 "Yes"), gen(substance_use)  //substance_use before sex

recode G17 (4 5=1 "Agree") (1 2 3=2 "Disagree"), gen(condom_preference)  //prefers to use condom during sex

gen rsb=1 if no_sexual_partners==2 | no_sexual_partners==3 | G5a==1 | G13==0
replace rsb=0 if rsb==.
label define rsb 0 "No" 1 "Yes"
label value rsb rsb

gen class=1 if A5=="ss1"
replace class=2 if A5=="ss2"
label define class 1 "SS1" 2 "SS2"
label value class class

recode night_sleep (1=0 "None") (2/4=1 "Once or more"), gen(night_sleepr)
********TABLE 1: SOCIO-DEMOGRAPHIC CHARACTERISTICS************

tab1 age_grp length_stay religion ethnicity A5 A6 A7 A8i A9i living_with night_sleep

*******TABLE 2: SEXUAL BEHAVIOUR OF ADOLESCENTS*********
gen age_sex=0 if G4b=="11" | G4b=="12.0" | G4b=="5years" | G4b=="7"
replace age_sex=1 if age_sex==. & G4b!=""
label define age_sex 0 "<13 yrs" 1 "13+yrs"
label value age_sex age_sex

recode G4c (1 3=1 "Wanted to have it/talked into it") ( 2 4=2 "Not wanted to/forced to"), gen(first_sex)


tab1 G4a age_sex first_sex G5a G6 G8 G10 G11 G13 G14 G17 no_sexual_partners substance_use condom_preference

*******TABLE 2.1: PROFILE OF ADOLESCENTS WITH RSB********
tab rsb
ta age_grp rsb, col chi
ta religion rsb, col chi
ta ethnicity rsb, col chi
ta A5 rsb, col chi
ta A6 rsb, col chi
ta A7 rsb, col chi
ta A8i rsb, col chi
ta A9i rsb, col chi
ta living_with rsb, col chi
ta night_sleep rsb, col chi


******TABLE 5: CORRELATES OF RSB********
*****==Univariate Model*****
logistic rsb i.age_grp, or nolog
logistic rsb i.religion, or nolog
logistic rsb i.ethnicity , or nolog
logistic rsb i.class, or nolog
logistic rsb i.A6, or nolog
logistic rsb i.A7, or nolog
logistic rsb i.A8i, or nolog
logistic rsb i.A9i, or nolog
logistic rsb i.living_with, or nolog
logistic rsb i.night_sleepr, or nolog
logistic rsb i.age_sex, or nolog
logistic rsb ib2.first_sex, or nolog
logistic rsb i.substance_use, or nolog

*****==Multivariate Model*****
logistic rsb i.age_grp i.class i.A6 i.A9i i.substance_use, or nolog



