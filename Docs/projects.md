% Understanding gender imbalances online with field experiments
% Andrea Blasco (ablasco@fas.harvard.edu) and Michael Menietti (mmenietti@fas.harvard.edu)
% \today

Introduction
============

Though the proportion of Internet users is nearly the same across the genders, researchers have found significant gender imbalances in online behavior:

* Only 13 percent of Wikipedia contributors are women [@hill2013wikipedia]; Wikipedia articles on women are more likely to be missing than are articles on men relative to Britannica [@reagle2011gender];
* Less than 5 percent of StackOverflow users answering technical questions are women [@vasilescu2012gender];
* Women make a small fraction of people going to hackathons or taking part in online competitions on crowdsourcing platforms (Innocentive, TopCoder, Kaggle).


The reasons behind this gender gap are not fully understood. It is clear that it is not due to discriminatory rules put in place on these platforms. Rather the culprit seems to be a mix of psychological motivations and institutional characteristics of the platforms that might have inadvertently promoted an imbalance.

We conjecture that an important mechanism of imbalance could be the combination of

1. Gamification & incentives
2. Differences in preferences between the genders

Online platforms use elements of game play to engage their members (rankings, game points, competition with others, etc.) and stimulate higher levels of user activity. If men and women have different inclinations towards these incentives, they might inadvertently stimulate an imbalanced participation.


<!-- 
1. **Preferences.** 
 -->

<!-- 
3. **Platforms are open.** If there are biases in the general population of internet users, then these are reflected also in the interactions occurring on online platforms. For example, @hannak2014bias finds that women receive fewer reviews after they complete a job on TaskRabbit, a marketplace for freelance tasks.
 -->
 
Though there exists a significant literature in economics examining gender differences in preferences over types of incentive schemes [@niederle2007women], the intellectual merit of the project is to use experimental methods to examine this issue and test different hypotheses in the context of online platforms. 

Experimental design
=====================

The context
--------------------

We designed two interventions in collaboration with HeroX.com, a crowdsourcing platform.  And we have started a conversation with people at the Wikimedia foundation to carry out similar experiments using Wikipedia contributors as potential subjects. We view HeroX and Wikipedia as examples of a competitive (platform users make submissions solving a given problem and the top submissions are awarded a cash prize) and collaborative environment, respectively. 

A study on collaborative incentives
-----------------------------------

<!-- 
The first experiment is based on this basic notion that an unrestricted choice set is preferable to one with restrictions and that such a preference relation should be independent of the gender. We test this prediction in the context of individual choices of  collaboration on an online problem solving activity on the online platform HeroX.com.
 -->

The first study is in collaboration with HeroX.com. The research goal is to understand how incentives to collaborate or compete affect effort and how these effects might differ between the genders. It is based on a solicitation experiment to compare the effects on participation in a problem solving task of different treatments:  (P) a solicitation awarding a cash _prize_ to top submissions made by an individual or a team; (T) a solicitation awarding a cash prize to top submissions made by a _team_ (but not those made by individuals); and (B) a _baseline_ solicitation with no incentives other than those already in use on the platform (a mix of reputation and prosocial incentives).

Standard economic theory predicts that the outcomes (e.g., participation, effort) under the prize treatment (P) should dominate those under both the team (T) and the baseline (B) treatments because the team treatment offers incentives that work only conditional on forming a team and the baseline offers no explicit incentives. Theoretically, such a dominance relation should be independent of the gender. So, let $y_{i, g}$ be the mean outcome variable conditional on the gender $g=\{m,f\}$ and the treatment $i=\{P,T,B\}$, then our (null) hypothesis is:
\begin{equation}
	\label{hypothesis}
	y_{P, g} \geq y_{j, g}  \quad \text{for each } j=T, B \text{ and } g=m,f.
\end{equation}

A violation of the above inequality might indicate that the gender imbalance may come from differences in the responses to incentives between the genders. If women's participation is negatively affected by an increase in competition, then we should observe $y_{B,f} > y_{P, f}$ which violates \eqref{hypothesis}. Likewise, if women's participation is positively affected by an increase in collaborative incentives, then we should observe $y_{T,f} > y_{P, f}$, which again violates \eqref{hypothesis}.

<!-- 
We also plan to examine these differences in detail by using fine grained and pre-determined measures of collaborative vs competitive behavior that are obtained through the platform.
 -->


A study on the effects of the perceived gender imbalance
-----------------------------------------

A second study is also in collaboration with HeroX.com. The research goal is to understand how the perceived gender composition of the other members of the platform affects individual decisions to participate. Beginning with laboratory experiments [@niederle2007women], men and women show different preferences for incentive schemes that performance comparisons to other individuals, e.g., contest-style payments. A woman is more likely to choose piece-rate compensation over contest compensation even when her performance should provide higher compensation in a contest. On average, women are moderately too conservative when selecting compensation schemes, even controlling for risk. Conversely, men are on average, far too enthusiastic to compete even when detrimental to compensation. At least for women, these preferences depend on the gender composition of the comparison group. In all-female groups, the effect is attenuated or disappears entirely. Given the environment in many online platforms has competitive aspects, we conjecture that this difference in preferences may be adding to gender disparities in platform participation.

The experiment consists of providing platform members with information about the gender composition of the most "active" other members to allow a comparison between different treatments: (A) a same-gender treatment (we show only members of the same gender of the one receiving the solicitation), (B) a distinct gender treatment (we show only members of the opposing gender of the one receiving the solicitation) and (C) a mixed-gender treatment (we show members of both genders).


In each treatment, everyone is sent a generic communication via email (e.g., a newsletter) featuring the profile of 3 platform members, a two-sentence description of what they did on the platform and a picture of their profile (where gender is recognizable). 

The dependent variables of interest are participation in one or more challenges, pageviews, submissions, and the cooperation rate, which is the fraction of participating individuals seeking to form a team

<!-- 
A second study is in collaboration with Wikipedia. Here the goal is to understand how men and women respond to a call for contributing to a Wikipedia entry associated with one of the genders as well as with or without competitive incentives. We imagine a 3x2 design where the Wikipedia entry can be about other famous women, other famous men, or neutral; and each solicitation can be either incentivized with a prize, or not incentivized.
 -->








































References
===========