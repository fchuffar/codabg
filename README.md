To create a Codalab competition, you have to generate a zip file with
the required files inside and upload the archive on the Codalab
platform. The *R* script `generate_bundle.Rmd` allows you to
automatically create a valid bundle by using the *R* terminal and `config.R` file.

Generate a Codalab bundle
=========================

In a *R* terminal, run the following command :
```
system("bash clean.sh") ;  
challenge_name="epismoke1.0"; 
rmarkdown::render("generate_bundle.Rmd")
```

Test the Codalab bundle
=======================

In a *R* terminal, run the following command :
`rmarkdown::render(input = "Bundle_test.Rmd", envir = new.env( ) )`

\[WIP\] Render a web site to previsualize the competition
=========================================================

It gives you the possibility to visualize your competition with a
minimalist website which looks like the Codalab platform.
`rmarkdown::render_site(input = "Web_page_generator.Rmd", envir = new.env( ) )`
