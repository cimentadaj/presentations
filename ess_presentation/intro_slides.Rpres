<style>
bold {font-weight: bold; }

.small-code pre code {
  font-size: 0.2em;
}

.section .reveal .state-background {
    background: white;
}

.section .reveal p {
   color: black;
   text-align:center;
   font-size: 1.8em;
}

.section .reveal h1,
.section .reveal h2 {
    color: black;
    text-align:center;
    width:100%;
}
</style>



The ess package
========================================================
author: Jorge Cimentada
date: 19/1/2018
autosize: true
width: 1700


<div align="center">
<img src="ess_logo.png"; style="width:700px; height:250px">
</div>

ess package
========================================================

The philosophy of the `ess` package is very simple

<div align="center">
"Concentrate on your analysis rather than on searching for information"
</div>

<br>

It fits with the general idea of obtaining data within R from packages such as: 
- [OECD](https://cran.r-project.org/web/packages/OECD/OECD.pdf)
- [World Bank](https://cran.r-project.org/web/packages/wbstats/vignettes/Using_the_wbstats_package.html)
- [Eurostat](https://cran.r-project.org/web/packages/eurostat/vignettes/eurostat_tutorial.pdf)

For a very cool compendium of 'data packages' see the series of posts by my good friend [Ilya Kashnitsky](https://ikashnitsky.github.io/2017/data-acquisition-one/)

ess package
========================================================

It aims to fix four broad problems:

- It's often difficult to keep track of all country/rounds/themes available in the ESS

- It's even trickier to find which countries participated in which rounds

- It's cumbersome to download/redownload data to search for variables

- Avoid leaving your 'analysis phase' to search for information

ess package
========================================================

Requirements:

- Internet connection

- Registered user at http://www.europeansocialsurvey.org/user/new

ess package
========================================================

There two family of functions

* `ess_*` functions download data  
 + *Always return a list*
 
<br>

* `show_*` functions retrieve information from the ess website
 + *Always return information as vectors*

Downloading rounds
========================================================

* `show_rounds()` returns the rounds available in the ess website

<br>

* `ess_rounds()` downloads the rounds available in the ess website
  +  `ess_rounds(4:5, "your@email.com")`
  
<br>

* `ess_all_rounds()` downloads all rounds available by default
  +  `ess_all_rounds("your@email.com")`

Downloading country rounds
========================================================

* `show_country()` returns the countries available that participated in at least one wave

<br>

* `show_country_rounds()` returns the rounds for which a country participated in

<br>

* `ess_country()` downloads specific rounds for a given country
  +  `ess_country("Spain", 1:2, "your@email.com")`
  
<br>

* `ess_all_cntrounds()` downloads all available rounds for a given country
  +  `ess_all_cntrounds("Spain", "your@email.com")`

Live example
========================================================

<div align='center'>
Let's code!

<br>
<br>

<a href="http://bit.ly/2FPKYqR">http://bit.ly/2FPKYqR</a>
</div>



Roadmap for the ess package
========================================================
* `show_themes()` and it's family

* Download `ess_*` for the SDDF data

* Download the data also in SPSS format

* Develop a complementary package to interact with the codebook and survey analyze the ESS data

* Add your requests/feedback!
  + `devtools::install_github("cimentadaj/ess")`

Future of the ess packages
========================================================

<div align="center">
Develop a small ecosystem of packages to analyze the ESS data easily
</div>

<br>

<div align="center">
<img src="ess_flow.jpg"; width=1700px; height=400px>
</div>

Resources
========================================================

* [Brief tutorial of the package](https://cran.r-project.org/web/packages/ess/vignettes/ess_r_stata_users.html)
* [The development repository; this is where I will be developing new features](https://github.com/cimentadaj/ess)
* [Bugs/issues/requests should be added here](https://github.com/cimentadaj/ess/issues)
* Follow [#rstats](https://twitter.com/hashtag/rstats?src=hash) and [@cimentadaj](https://twitter.com/cimentadaj) on Twitter to hear about new releases
