# Answers to the comments made by reviewers on the SoSen Workshop of the GIScience Conference 2021

# Reviewer #1
## Overall
The manuscript is an extension of the work by Gardener et al. 2020. It did not become entirely clear to me if they used a subset of the same data or if the authors collected a new sample. The extension of analysis is in the consideration of age class and time of the day. 

However, given the small sample size I have doubts that the statistical analysis is really sound (but this could of course be proven).

Since the description of the data preprocessing is relatively short I might have misinterpreted some results but there might be a flaw in the way that contributions are used.



## Method
It did not become clear to me how the users there selected. Was anybody with ore than 1500 changesets asked to participate or was another filter used? Or is the survey by Gardener et al. 2020 available and has been used for the analysis (but filtered to users with more than 1500 changesets)?


The authors used a relatively seldom used test - which is fine in principle. I found the hint that the design should be balanced (which seems not the case for the data analyzed). In addition each cell in the cross-table analyzed should have an n of at least five - which is presumably not the case for all tests run, especially for the test of the interactions given the relatively small sample size. (From figure 5 it is obvious that some combination don't have a single entry. I think this should be discussed. Combining age classes to get bigger group sizes seems a reasonable strategy to increase the statistical power of the analysis.


It would be interesting to know how users contributed across countries since this could be a potential confounding factor. For users from countries with several time zones the averaging could have a confounding effect if e.g. more female than male mappers originate from these countries. If females would be coming from a subset of countries on might wonder if the differences are due to gender or due to country.


I was wondering why not using a generalized linear model of the (quasi)poisson or negative binomial family to study the effects of the different predictors/grouping factors in combination. I would assume that these will meet the distribution of the data.
An interesting question would be if a few male power mappers were the reason for the difference.



# Reviewer #2
## Overall
This manuscript is adding to the literature describing and defining who is actually the ‘volunteer’ behind OSM, and identifying potential biases in contributors and coverage. 

## Website 
The paper does this through analysing the gender, age and contributions from those who contributed more than 1500 changes.  The data was collected from the “how did you contribute to OpenStreetMap” website, but more information is needed on this website.  The citation to the website indicates a 2015 date, were all of these data from 2015 or prior? 

## Participants, who are they?
There is quite a bit of literature about the long-tale distribution of OSM contributors, perhaps indicate where in that distribution you are using for the sample.  Are you just capturing power users?  Or is 1500 small enough to capture some of the average users?  It’s unclear  why participants that contributed fewer than 1500 changesets were excluded.  


Perhaps the analysis could be expanded by simply including those, or choosing a much smaller cut-off (like 10).  For a study that includes gender and time as variables, it would be helpful to have more than 30 women included as once that is broken down by age group and then by day, it’s unclear how many women were in each age bracket and if this is significant or these few women were anomalies. 

The unusual peak of women contributing at 5am is a very interesting finding, which later the authors nuance with the determination that these German users.  More information is needed here—how many German women (unique contributors) are contributing at 5am?  Is it just one or two?  What is the significance of this finding?  Why are they contributing at 5am?  Are they contributing through an exercise app?  Are they paid contributors (e.g. for Apple)?  Was this before the pandemic? 

## Time zone
With using an average time zone in the USA/Canada, it seems this finding couldn’t be discerned for the USA/Canada as 5am in New York is 2am in California, and the motivations for contributing at 2am are quite different for contributing at 5am.  Also, the vast majority of Americans live on either east coast or west coast time zones so, averaging them to a generic middle is problematic for discerning temporal patterns.

Perhaps an indication of the geography of these participants and the volume by geography. What about Russia? Were Russian OSM contributions considered?  How were their time zones assessed? 

In each  table it would be helpful to indicate which results are significant. In each of the graphs (e.g. Figure 4, 5)  it would be helpful to indicate what the N is for women and men in each category. 


## Age/Gender Characteristics
Lastly, it would be helpful if the authors provided a little more information, or at least some speculation in the conclusions as to why they are seeing these patterns.  For example those over 70 are likely to be pensioners/retirees where the time/day of the week is less structured than those in their 40s.  Those under 24 are less likely to have children, so the gender difference is unlikely to be because of childcare responsibilities, so what would be the difference?

