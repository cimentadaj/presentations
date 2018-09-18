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



El paquete essurvey
========================================================
author: Jorge Cimentada
date: 2018/09/20
autosize: true
width: 1700


<div align="center">
<img src="ess_logo.png"; style="width:700px; height:250px">
</div>

<div align="center">
https://bit.ly/2OAPihI
</div>

essurvey
========================================================

La filosofia del paquete `essurvey` package es muy simple

<div align="center">
"Concentrate en tus analisis mas que en buscar informacion"
</div>

<br>

Encaja con la idea general de obtener datos en R tal y como:
- [OECD](https://cran.r-project.org/web/packages/OECD/OECD.pdf)
- [World Bank](https://cran.r-project.org/web/packages/wbstats/vignettes/Using_the_wbstats_package.html)
- [Eurostat](https://cran.r-project.org/web/packages/eurostat/vignettes/eurostat_tutorial.pdf)

Para un compendio bastante interesante paquetes de datos, vease los posts de [Ilya Kashnitsky](https://ikashnitsky.github.io/2017/data-acquisition-one/)

essurvey
========================================================

Su objetivo es solucionar cuatro problemas:

- A menudo es dificil hacer un seguimiento de todos los paises / rondas / temas disponibles en el ESS

- Es aun mas complicado encontrar que paises participaron en que rondas sistematicamente

- Es igual de complicado descargar / recargar diferentes rondas para buscar variables

- Te ayuda a evitar abandonar tu 'fase de analisis' para buscar informacion

essurvey
========================================================

El paquete fue aceptado y cumple con los estandares de rOpensci

<div align="center">
<img src="ess_ropensci.png"; width=1500px; height=300px>
</div>

[Y tiene su propia pagina web](https://ropensci.github.io/essurvey/)!

essurvey
========================================================

Requerimientos:

- Conexion de internet

- Registrarse en http://www.europeansocialsurvey.org/user/new

essurvey
========================================================

Hay tres familias de funciones

* `import_ *` funciones para descargar datos en R
* `download_ *` funciones para descargar datos en Stata y SPSS a tu ordenador
* `show_ *` recuperan informacion del la pagina web de la ESS

<br>

* `set_email(your@email.com)` hace un login directamente a la ESS
* Solo tienes que hacerlo *una vez* y es suficiente.
* `recode_missings` se encarga de recodear los valores 97, 98 y 99 automaticamente.

*IMPORTANTE: tener tu correo registrado en la pagina de la ESS*

Descargar rondas
========================================================

* `show_rounds()` retorna las rondas disponibles en la ESS

<br>

* `import_rounds()` descarga las rondas directamente a R
  +  `import_rounds(4:5)`
  
<br>

* `import_all_rounds()` Descarga todas las rondas disponibles directamente a R
  +  `import_all_rounds()`

Descargar rondas de paises
========================================================

* `show_country ()` devuelve los paises disponibles que participaron en al menos una ronda

<br>

* `show_country_rounds ()` devuelve las rondas en las que un pais participo

<br>

* `import_country ()` descarga rondas especificas para un pais
  + `import_country("Spain", 1:2)`
  
<br>

* `import_all_cntrounds()` descarga todas las rondas disponibles para un pais
  + `import_all_cntrounds("Spain")`

Ejemplo en vivo
========================================================
source: ess_intro.R

<div align='center'>
Vamos a codear
</div>

Hoja de ruta para los paquetes ESS en R
========================================================

* Descargar `import_*` los datos de los pesos (SDDF)

* Desarollar dos paquetes complementarios para interactuar con el codebook y analizar los datos de la ESS

* Prueba las ultimas versiones y pedi features especiales!
  + `devtools::install_github("ropensci/essurvey")`

Futuro de los paquetes de la ESS
========================================================

<div align="center">
Desarrollar un ecosistema de paquetes para analizar los datos de ESS en R
</div>

<br>

<div align="center">
<img src="ess_flow.jpg"; width=1700px; height=400px>
</div>

Aplicaciones actuales de essurvey
========================================================

Descarga los datos de la ESS con etiquetas en castellano: https://essurvey.shinyapps.io/ess_castellano/

Ideas de otras aplicaciones:
* Analizar datos interactivamente con una interfaz
  * Ensenar graficas para visualizar patrones
  * Esto puede servir mucho a periodistas buscando responder preguntas

Recursos
========================================================

* [Breve tutorial del paquete](https://cran.r-project.org/web/packages/essurvey/vignettes/intro_ess.html)
* [El repositorio de desarollo; aqui es donde vamos anadir nuevos cambios](https://github.com/ropensci/essurvey)
* [Bugs/features pueden ser anadidos aqui](https://github.com/ropensci/essurvey/issues)
* Seguir [#rstats](https://twitter.com/hashtag/rstats?src=hash) y [@cimentadaj](https://twitter.com/cimentadaj) en Twitter para saber de nuevos releases
