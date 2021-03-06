{smcl}
{* *! version 0.0.1  08may2018}{...}
{title:Title}

{pstd}{helpb ziop##nop:nop} {space 2}{c -} Three-part nested ordered probit regression{p_end}
{pstd}{helpb ziop##ziop2:ziop2} {c -} Two-part zero-inflated ordered probit regression{p_end}
{pstd}{helpb ziop##ziop3:ziop3} {c -} Three-part zero-inflated ordered probit regression{p_end}


{title:Syntax}

{pstd}{cmd:nop} {space 2}{depvar} {it:indepvars} {ifin} {bind:[{cmd:,} {it:options}]}{p_end}

{pstd}{cmd:ziop2} {depvar} {it:indepvars} {ifin} {bind:[{cmd:,} {it:options}]}{p_end}

{pstd}{cmd:ziop3} {depvar} {it:indepvars} {ifin} {bind:[{cmd:,} {it:options}]}{p_end}


{synoptset 24 notes}{...}
{p2coldent :{it:indepvars}}list of the independent variables in the regime equation{p_end}



{synoptset 26 tabbed}{...}
{synopthdr}
{synoptline}

{syntab :Model}
{synopt :{opth pos:indepvars(varlist)}} independent variables in the outcome equation conditional on the regime s=1 for nonnegative outcomes in the {cmd:nop} and {cmd:ziop3} regressions; by default, it is identical to {it:indepvars}.{p_end}

{synopt :{opth neg:indepvars(varlist)}} independent variables in the outcome equation conditional on the regime s=-1 for nonpositive outcomes in the {cmd:nop} and {cmd:ziop3} regressions; by default, it is identical to {it:indepvars}.{p_end}

{synopt :{opth out:indepvars(varlist)}} independent variables in the outcome equation of the {cmd:ziop2} regression; by default, it is identical to {it:indepvars}.{p_end}

{synopt :{opt inf:cat(choice)}} value of the dependent variable in the regime s=0 (an inflated choice in {cmd:ziop2} and {cmd:ziop3} models; a neutral choice in {cmd:nop} model); by default, it equals 0.{p_end}
{synopt :{opt endo:switch}} use endogenous regime switching instead of default exogenous switching.{p_end}

{syntab :SE/Robust}
{synopt :{opt robust}} use robust sandwich estimator of variance; the default estimator is based on the observed information matrix.{p_end}
{synopt :{opth cluster(varname)}} clustering variable for the clustered robust sandwich estimator of variance{p_end}

{syntab :Reporting}
{synopt :{opt vuong}} perform the Vuong test (Vuong 1989) against the conventional ordered probit (OP) model (not available for {cmd:ziop2}).{p_end}
 
{syntab :Maximization}
{synopt :{opt initial(string)}} whitespace-delimited list of the starting values of the parameters in the following order: gamma, mu, beta+, alpha+, beta-, alpha-, rho-, rho+ for the {cmd:nop} and {cmd:ziop3} regressions, and gamma, mu, beta, alpha, rho for the {cmd:ziop2} regression.{p_end}
{synopt :{opt nolog}} suppress the iteration log and intermediate results.{p_end}
{synoptline}

{pstd}See {help ziop_postestimation:ziop postestimation} for features available after estimation.{p_end}

{title:}


{marker nop}{...}
{p 4 7}{cmd:nop} estimates a three-part nested ordered probit regresion (Sirchenko 2020) of an ordinal dependent variable {depvar} on three sets of independent variables: {it:indepvars} in the regime equation, {opt posindepvars(varlist)} in the outcome equation conditional on the regime s=1, and {opt negindepvars(varlist)} in the outcome equation conditional on the regime s=-1.{p_end}

{marker ziop2}{...}
{p 4 7}{cmd:ziop2} estimates a two-part zero-inflated ordered probit regression (Harris and Zhao 2007; Brooks, Harris and Spencer 2012; Bagozzi and Mukherjee 2012) of an ordinal dependent variable {depvar} on two sets of independent variables: {it:indepvars} in the regime equation and {opt outindepvars(varlist)} in the outcome equation.{p_end}

{marker ziop3}{...}
{p 4 7}{cmd:ziop3} estimates a three-part zero-inflated ordered probit regression (Sirchenko 2020) of an ordinal dependent variable {depvar} on three sets of independent variables: {it:indepvars} in the regime equation, {opt posindepvars(varlist)} in the outcome equation conditional on the regime s=1, and {opt negindepvars(varlist)} in the outcome equation conditional on the regime s=-1.{p_end}

{p 4 7}The actual values taken on by the dependent variable are irrelevant, except that larger values are assumed to correspond to "higher" outcomes.{p_end}

{title:Examples}

{pstd}Setup{p_end}
       . webuse rate_change

{pstd}Fit three-part nested ordered probit model with exogenous switching{p_end}
       . nop rate_change spread pb houst gdp, neg(spread gdp) pos(spread pb) inf(0)

{pstd}Fit three-part nested ordered probit model with endogenous switching and report Vuong test of NOP versus ordered probit{p_end}
       . nop rate_change spread pb houst gdp, neg(spread gdp) pos(spread pb) inf(0) endo vuong

{pstd}Fit two-part zero-inflated ordered probit model with exogenous switching{p_end}
       . ziop2 rate_change spread pb houst gdp, out(spread pb houst gdp) inf(0)

{pstd}Fit three-part zero-inflated ordered probit model with exogenous switching{p_end}
       . ziop3 rate_change spread pb houst gdp, neg(spread gdp) pos(spread pb) inf(0)

{pstd}Fit three-part zero-inflated ordered probit model with endogenous switching and report Vuong test of ZIOP-3 versus ordered probit{p_end}
       . ziop3 rate_change spread pb houst gdp, neg(spread gdp) pos(spread pb) inf(0) endo vuong

{title:Stored results}

{pstd}
{cmd:nop}, {cmd:ziop2} and {cmd:ziop3} store the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:e(N)}}number of observations{p_end}
{synopt:{cmd:e(k_cat)}}number of categories{p_end}
{synopt:{cmd:e(k)}}number of parameters{p_end}
{synopt:{cmd:e(df_m)}}model degrees of freedom{p_end}
{synopt:{cmd:e(r2_p)}}McFadden pseudo-R-squared{p_end}
{synopt:{cmd:e(ll)}}log likelihood{p_end}
{synopt:{cmd:e(ll_0)}}log likelihood, constant-only model{p_end}
{synopt:{cmd:e(vuong)}}Vuong test statistic{p_end}
{synopt:{cmd:e(vuong_aic)}}Vuong test statistic with AIC correction{p_end}
{synopt:{cmd:e(vuong_bic)}}Vuong test statistic with BIC correction{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(cmd)}}{cmd:nop}, {cmd:ziop2} and {cmd:ziop3}, respectively{p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable{p_end}
{synopt:{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt:{cmd:e(ll_obs)}}vector of observation-wise log-likelihood{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

{title:References}

{p 4 7}Bagozzi, B. E., and B. Mukherjee. 2012. A mixture model for middle category inflation in ordered survey responses. {it:Political Analysis} 20: 369-386.{p_end}
{p 4 7}Brooks, R., M. N. Harris, and C. Spencer. 2012. Inflated ordered outcomes. {it:Economics Letters} 117: 683-686.{p_end}
{p 4 7}Harris, M. N., and X. Zhao. 2007. A zero-inflated ordered probit model, with an application to modelling tobacco consumption. {it:Journal of Econometrics} 141: 1073-1099.{p_end}
{p 4 7}Sirchenko, A. 2020. A model for ordinal responses with heterogeneous status quo outcomes. {it:Studies in Nonlinear Dynamics & Econometrics} 24 (1).{p_end}
{p 4 7}Vuong, Q. H. 1989. Likelihood ratio tests for model selection and non-nested hypotheses. {it:Econometrica} 57: 307-333.{p_end}
