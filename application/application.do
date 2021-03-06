
// assume that all contents of the `package` folder are installed

// make the current directory working directory (change the address to that on your own computer!)
// cd C:\Users\ddale\YandexDisk\hsework\gauss-mata\cnop\application\
cd "C:\Users\user\Documents\Dale\Our paper on Github\cnop\sandbox"

use rate_change.dta, clear

set more off
oprobit rate_change spread pb houst gdp, nolog
estat ic

set more off
nop rate_change spread pb houst gdp, neg(spread gdp) pos(spread pb) inf(0) nolog vuong

set more off
ziop2 rate_change spread pb houst gdp, out(spread pb houst gdp ) infcat(0) nolog

set more off
ziop3 rate_change spread pb houst gdp, neg(spread gdp) pos(spread pb) inf(0) nolog vuong 

predict p_zero, zeros
predict p_reg, regimes
tabstat p_zero* p_reg*, stat(mean)

ziopmargins, at (pb=1, spread=0.426, houst=1.6, gdp=6.8)

ziopprobabilities, at (pb=1, spread=0.426, houst=1.6, gdp=6.8)

ziopcontrasts, at(pb=0, spread=1.116, houst=1.97, gdp=7.4) ///
               to(pb=1, spread=1.116, houst=1.97, gdp=7.4)
			   
ziopcontrasts, at(pb=1, spread=0.426, houst=1.6, gdp=6.8) ///
               to(pb=0, spread=0.426, houst=1.6, gdp=6.8)

			   
//ziopcontrasts, at(pb=0, spread=0.658, houst=2.15, gdp=7.2) ///
 //              to(pb=1, spread=0.658, houst=2.15, gdp=7.2)

//ziopcontrasts, at(pb=0, spread=-0.194, houst=1.56, gdp=9.4) ///
 //              to(pb=1, spread=-0.194, houst=1.56, gdp=9.4)
			   
			   
// vuong example ZIOP-3 vs ZIOP-2
quietly ziop3 rate_change pb spread houst gdp, neg(spread gdp ) pos(pb spread) inf(0) nolog
est store ziop3_model
quietly ziop2 rate_change spread pb houst gdp, out(spread pb houst gdp) inf(0)
est store ziop2_model
ziopvuong ziop3_model ziop2_model


//classification example

set more off
quietly ziop3 rate_change pb spread houst gdp, neg(spread gdp ) pos(pb spread) inf(0)
ziopclassification

set more off
quietly ziop2 rate_change spread pb houst gdp, out(spread pb houst gdp ) infcat(0) nolog
ziopclassification

set more off
quietly nop rate_change spread pb houst gdp, neg(spread gdp) pos(spread pb) infcat(0)
ziopclassification


// view help
view ../package/ziop.sthlp
view ../package/ziop_postestimation.sthlp

