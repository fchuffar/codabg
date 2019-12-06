To create a Codalab competition, you have to generate a zip file with
the required files inside and upload the archive on the Codalab
platform. The *R* script `Bundle_generator_-_cmd.Rmd` allows you to
automatically create a valid bundle by using the *R* terminal to ask you
some questions in order to personalize the competition.

Generate a Codalab bundle
=========================

In a *R* terminal, run the following command :
`rmarkdown::render(input = "Bundle_generator_-_cmd.Rmd", envir = new.env( ) )`

You can also generate a toy bundle, with the parameters by default, with
*Rscript* :
`Rsript -e 'rmarkdown::render(input = "Bundle_generator_-_cmd.Rmd", envir = new.env( ) )'`

Test the Codalab bundle
=======================

In a *R* terminal, run the following command :
`rmarkdown::render(input = "Bundle_test.Rmd", envir = new.env( ) )`

\[WIP\] Render a web site to previsualize the competition
=========================================================

It gives you the possibility to visualize your competition with a
minimalist website which looks like the Codalab platform.
`rmarkdown::render_site(input = "Web_page_generator.Rmd", envir = new.env( ) )`
